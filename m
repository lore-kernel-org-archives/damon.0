Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D23AA4E4;
	Wed,  2 Sep 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347498; cv=none; b=IYpjZDXLwPoXaggIMuAylUBF/AzTdcqBUMAJhhE7r7yEovjLgJ+bop6J/q4SoylWtbiySrIo/Jeg86S8kpcMtB3jrQrBL4WKBbd/K2Uac33rWcjekYUpvXa/ZqAVzeaTGB2oVMj0YkdYyY5WIcOql39Aa0DZ+7vbhE/bTwW+kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347498; c=relaxed/simple;
	bh=QU5hPoaD3ElLgmwVvxdHA32Gn9EZTR4pgNVm2/cAjBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=coJiNrDgXT/cLza+D59PGpGPwetRO+iAhEL5e7j7WEpjmbZ/s1VoZFh0rVWtvN+2pFTSLlTtXY+c6GhiBQ8rJ4MivlzqMF4jSAWMUPBR3xjgsaKudSlCJ6zRMUIU5TdEnqYj7NPxZSbjvLKFoaRAh9kadkfT6Da5lEhGh0xuTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aybAZ+P7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aybAZ+P7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4EC1F00ACF;
	Wed,  2 Sep 2026 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788347494;
	bh=6y4Sid6XTEIIpFKa5O3xBLjBGa0uNaO7E4h8jBqU6IY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aybAZ+P7yXr+8bje9FZkvvGZVrkJ6jYX7k+Ptmx4yjLrP1pXIXCK8NeGvuVd2KmPA
	 UyokrqdKUhwxEBKS/w5WyY0C2m+Ce02sORu1OODuVTAbrZ5jZZfT6IZfWeYXoGkRAo
	 k8xAS4hzPkeC84QFRX31UDXZFVdn1J6JaXtdLUV4iGqaIjOzSVvwS2+p8pehSqaW1x
	 NlXAzC84oo1wbqu7/zgdIBvjsUmiIRmVTeIpLvpEjYsanvQOc7os9Yo7FSH7icVRhO
	 VOqxTd0fdjB18NVtaug047xwTBdRQHfasiE915CGlMXGTQo5AsgBzv2QMG6SWUZjgx
	 Jr4dF7azy/qqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/11] mm/migrate: pass migrate_control to
 migrate_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: dsterba@suse.cz, "Jeff Layton" <jlayton@kernel.org>, linux-cxl@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, damon@lists.linux.dev, kvm@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>
In-Reply-To: <20260902-migrate-refactor-shivank-v1-10-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-10-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:11:33 +0000
Message-Id: <20260902111133.9C4EC1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized `async_ctl` structure is passed to `migrate_folios_b=
atch()` when `ctl->mode =3D=3D MIGRATE_ASYNC`.
--

commit c0d77495768f5e8f1e4f178497970348e9942beb
Author: Shivank Garg <shivankg@amd.com>

mm/migrate: pass migrate_control to migrate_pages()

migrate_pages() still takes mode and reason separately and reconstructs a
migrate_control internally. This prevents callers from supplying additional
migration policy without extending its argument list.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index e4bc7122076e1..549f8b57092cc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2359,7 +2354,7 @@ int migrate_pages(struct list_head *from, new_folio=
_t get_new_folio,
>  	rc_gather +=3D rc;
> =20
>  	rc =3D migrate_lru_folios(from, get_new_folio, put_new_folio,
> -			private, &ctl, &ret_folios, &stats);
> +			private, ctl, &ret_folios, &stats);
>  	if (rc < 0) {
>  		rc_gather =3D rc;
>  		goto out;

[Severity: High]
Does this execution path introduce a regression where an uninitialized
structure is passed when the initial mode is MIGRATE_ASYNC?

Looking at __migrate_lru_folios() which is called via migrate_lru_folios():

mm/migrate.c:__migrate_lru_folios() {
	struct migrate_control async_ctl;

	if (ctl->mode =3D=3D MIGRATE_ASYNC) {
		rc =3D migrate_folios_batch(...);
		goto out;
	}

	async_ctl =3D *ctl;
	async_ctl.mode =3D MIGRATE_ASYNC;
...
out:
...
	} else if (!list_empty(&split_folios)) {
		migrate_folios_batch(&split_folios, get_new_folio, put_new_folio,
				private, &async_ctl, ret_folios,
				NULL, stats, 1);
	}
}

If a caller invokes migrate_pages() with MIGRATE_ASYNC (such as DAMON or
NUMA balancing), the execution jumps to the out label, skipping the
initialization of the async_ctl structure.

If a large folio fails to migrate and is successfully split, the split foli=
os
are placed into the split_folios list. Then migrate_folios_batch() is called
to retry the split folios, passing the uninitialized async_ctl structure.

Could this regression lead to unpredictable migration behavior by using
garbage data from the stack for the mode and reason fields, potentially
sleeping in paths that expect asynchronous behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D10
