Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCB23393F
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788067432; cv=none; b=f+tmMQvNEJH+DTadw0QjQ7nuvI8Xh/ftM6cGeuYPWHjTQrhlDjTh6izVoU0gdjT6tz6+wbq5UrvWr/hVMUzmVxTD20Db7rtxlx+nOQD0ffb986VsP0aLM1b1vVPxJ6CqmO96UcbNh8I2PRNo6B1zWfR7kKesHA99BtgJggoiRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788067432; c=relaxed/simple;
	bh=jVLOL2Dt6ATOphZWvaEvoZKvJXCpyfLywS8JhCN8BlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TXbjgBwPAOmooj6uMVKQVkBqs+pitcoK5J2jDUlvhuEYuKGSyA4DPBpPDA6zdzm38+pE/YPa8/BbfQv9aRE0QCyolCjc5BhU3+REJx9pprd/w8zjurgr8gBtNwSlSlrR0hPa+QBy2oRL9Z+TI9eywVCXM0iEFembQElyY5eFSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWzC/lKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWzC/lKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909971F000E9;
	Sun, 30 Aug 2026 05:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788067430;
	bh=6vbyfazQzLMf8uAiHs2quInpNP8lgEIoGl39bxfbhzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JWzC/lKErxEJM+vs+9JLxVNrzDyDIvw+xH6+eO1g+8G/J2SOFBHPg72MvuF8FdwhQ
	 qzddV50K3drPEHv2/71kn6dOUkEJ2IKAJj0dwAgqsZaGiSWYQkAmoOjVFnhWLLyqqw
	 KHGRGHDq+yJGbkIIBl6egMP48AQN8NnEObZepCfBBdO96ExiSXjeDj/ipCzetMbH7K
	 BfXxcVQqTEEzVmg52fh1RWdnzHtaWYk3Ri9biD1mLDxTtD4qbEKp4c0M8c45NWIpyj
	 QsnEix5Nt8DrGPnwpLb1jwWuqyFxyLfdsgTtaPVp4ObeyAThlNqAlxhqX8+5EK2ZfI
	 4tEPxg4CXHhMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] mm/damon: support flush-assisted access bit
 clearing for monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830051407.50008-5-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
 <20260830051407.50008-5-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 05:23:50 +0000
Message-Id: <20260830052350.909971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON's access sampling clears the accessed bit of the sampled page and
> re-reads it one sampling interval later.  The clearing uses the
> non-flushing primitives, deliberately trading accuracy for low
> overhead: cached TLB translations survive the clearing, and accesses
> through such cached translations do not perform page table walks, hence
> do not set the accessed bit again.  The bit therefore re-arms at the
> TLB-refill rate rather than the actual access rate.
>=20
> For most setups this is a good trade-off, since TLB pressure re-walks
> hot pages frequently anyway.  It breaks down when translations are
> long-lived, most prominently on virtualization hosts backing guest
> memory with 1 GiB hugetlb pages: covering hundreds of GiB takes only
> hundreds of TLB entries, translations essentially never get evicted,
> and secondary MMU (e.g. KVM/EPT) accessed bits cleared via
> mmu_notifier_clear_young() are rarely set again.  Measurements on a
> [ ... ]
>=20
> DAMOS filter paths keep the non-flushing behavior unconditionally.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830051407.5000=
8-1-kiyer@crusoe.ai?part=3D4

