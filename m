Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3E38D41C
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989351; cv=none; b=eRR4Dz42YEITA2E5Ufp7tsPlo8ndrdscsOzfRnmVZyT7AXtiIAW3PxSRB6YV5B18p0V4h+JmI4fV7C3HItFoJkszIRyP1AHAnRuyVf4RfaBf7gPb9ULkk6xsgQcASi4UOKNBnYzjYPFhG4jNDcFSo3l5D55VuUAzwLP8i5xpUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989351; c=relaxed/simple;
	bh=uCs3VwinKSHyvBmJlv8SsyOIZWWSnPP4pdXquVMqT2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BrK1BYNPB7weWbT4XaW08an4aBqC2FadMGD/i2eNkAVmtgUnm8XFcNzvMa7gHRJXiMIek4SfwRWjGkcFrn7B77yyGVyBeXfPt116+h5uixhPV5zQ4bykfMFPsS8oOe5UAxZ6hvBarQfPFEkqLHhNZ8zQj8WRb7sbKUisxMWCnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnYQ8VcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnYQ8VcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D441F000E9;
	Thu,  2 Jul 2026 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782989350;
	bh=j2l+4Mkx/9zbfu2JM9v3NS9B3oGz/MpL7ofBcgVEebg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RnYQ8VcCI4LE6i7LG0MBvJAxGGFMdOEmqD7yDemgaytLnAUvkyLka/qGvIQM3QJq9
	 dhTLJKBa4lb84jM7uWEkTovMN+pZkjeQCxqa25yP7gOolWwyNJpNWeA/RrjIrDnnnG
	 rIB2T771mNdjNq3vQ0DLxnkKCnBQee0OjXbB9LU4UGGLynlX3o//6nAg3YL+kz9JiI
	 AeknbJWVU9Izpn6hpw+y9TrEK45Kox1A65e4zAkK3oBv2aDAUlfdIVY3Ki54lcHzfi
	 gwXUsR10yMxxw/RGydZsL2RpS0G2dAc37btNPwJV0exDCQGockaVpiP8+SiWEUFasj
	 b6v3omo4nb8nA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND RFC PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lian Wang" <lianux.mm@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702094633.75658-6-lianux.mm@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <20260702094633.75658-6-lianux.mm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:49:08 +0000
Message-Id: <20260702104909.A4D441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect virtual address advancement skips valid memory regions, =
overshoots unaligned folios, and corrupts DAMOS statistics.
- [High] Missing validation for driver-allocated compound pages before call=
ing split_folio_to_order().
--

commit 8064bd2b9a44cd475dbdec8fba8f8de5e1726797
Author: Lian Wang <lianux.mm@gmail.com>

mm/damon/vaddr: implement DAMOS_SPLIT handler
   =20
Implement the vaddr operations layer handler for DAMOS_SPLIT.
For each folio in the target region that is larger than the
scheme's target_order, split it via split_folio_to_order().
   =20
This supports both anonymous and file-backed (e.g. tmpfs/shmem)
folios, covering KVM guest memory backed by THP tmpfs.

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 8bfc6dcc635d5..73cb61c655fc7 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c

[ ... ]

> @@ -940,6 +940,83 @@ static unsigned long damos_va_collapse(struct damon_=
target *target,
>  	return applied;
>  }
> =20
> +static unsigned long damos_va_split(struct damon_target *target,

[ ... ]

> +		folio_sz =3D PAGE_SIZE << folio_order(folio);
> +
> +		if (folio_order(folio) > target_order) {
> +			if (!folio_trylock(folio)) {
> +				folio_walk_end(&fw, vma);
> +				goto unlock;
> +			}
> +			folio_get(folio);
> +			folio_walk_end(&fw, vma);
> +
> +			if (!split_folio_to_order(folio, target_order))

[Severity: High]
Can this call to split_folio_to_order() trigger a kernel panic if the folio
is a driver-allocated compound page?

folio_walk_start() can return driver-allocated compound pages mapped into
normal VMAs. These pages will have a folio_order() greater than zero, but
they lack the expected LRU, anonymous, or pagecache metadata.=20

Should there be a check here to ensure the folio is splittable (for example,
verifying it is an LRU page) before attempting to split it?

> +				applied +=3D folio_sz;
> +
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			*sz_filter_passed +=3D folio_sz;
> +			addr +=3D folio_sz;

[Severity: High]
Could this advancement logic overshoot the folio boundary?

If the iterator starts in the middle of a large folio, advancing addr by the
unadjusted folio_sz might push the address past the actual end of the folio.

> +		} else {
> +			folio_walk_end(&fw, vma);
> +			*sz_filter_passed +=3D chunk_sz;
> +			addr +=3D chunk_sz;

[Severity: High]
Does advancing by chunk_sz here accidentally skip all subsequent memory
within the 2MB chunk?

If folio_walk_start() returns an order-0 folio or any folio smaller than
target_order, the else branch advances addr by chunk_sz (2MB). This appears
to skip over any remaining folios that might exist in the rest of the chunk.

> +		}
> +		mmap_read_unlock(mm);
> +		cond_resched();
> +		continue;
> +
> +unlock:
> +		*sz_filter_passed +=3D chunk_sz;
> +		addr +=3D chunk_sz;

[Severity: High]
Does advancing by chunk_sz in this error path inflate the DAMOS statistics
and skip over remaining memory?

If a VMA check fails, or if folio_trylock() fails above, the loop jumps
to unlock and adds chunk_sz (2MB) to both sz_filter_passed and addr. This
seems like it would bypass the rest of the memory in the chunk and report
incorrect statistics for the filtered size.

> +		mmap_read_unlock(mm);
> +		cond_resched();
> +	}
> +
> +out_mmput:
> +	mmput(mm);
> +	return applied;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094633.7565=
8-1-lianux.mm@gmail.com?part=3D5
