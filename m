Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3733FF88A
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882814; cv=none; b=rqcBI2+emNxpBchAygjohbe1yCF8BklbwYgu/spWuqEOx4qm4FbN2Y/BAFQAWyVE6tweot+e9kqvFhc503jd0EjngJRjmaDrpgeArKlQyBC0k98u/vN9EuQWVowWPNexHvpLOH4UhISV+/tNQkCq94kO56X5ij+L3pqu34lieXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882814; c=relaxed/simple;
	bh=988ZzJgwVf7erwFTN6W49VAKFdxuyvF8Hy/2qsMMy6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XIDvU/jADDuK5PQ9G1p+Ae/7h9ZnFkNKwJOKO8m2SNFA0KDwZGhzfecYbBNYNlIwo6aj2mDgml5vLAwNlmi02RjU8ipqPuJdyE5SdsSZOTuTSZYwmI9Jxpk+W2SWvqW1iveBqfLqsXkDaTBQvRr2GpLyNs8vW1C6+piSW24Jp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwm1PyOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwm1PyOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F021F000E9;
	Wed, 27 May 2026 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882810;
	bh=GjUsX/mUiuaF0BbaaEp7LqrGCFgJ9DCIaofVhBvQr/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qwm1PyOA+HhIxHnnsKRzKDsUpQGHCX8zDwrnbJZKPC6ELT3S9ND+0E82kIMINfLMX
	 Qo2D3utZyjVgl0sObTiq0QKmvPZq6fseqKk3e1pFRvv6B49o8RZD4BSVVRvm3F939H
	 T2twJnwPvlKLMmhp/SgUtITd0kG11R7CIxu9q713H/+Dics/TaN+BB+pMj7KDfEqBd
	 jIgC41MYWq6uz43MrI+G/NsCKPEjUKrBuqfnoDaFHPGOsr7ngi1jmncdXUN3Lwqwvt
	 TGQiGyBO/nhPgHGiYMUa86edsZrEOX5+GSW62L9vUCqbgZtlyc4SDUyOhW6kq0Ouyh
	 Zy0oaANeKVemQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] mm: switch to anon_vma_tree_t APIs in preparation
 for ANON_VMA_LAZY
Reply-To: sashiko-reviews@lists.linux.dev
To: tao <tao.wangtao@honor.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260527110147.17815-5-tao.wangtao@honor.com>
References: <20260527110147.17815-5-tao.wangtao@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:53:29 +0000
Message-Id: <20260527115330.47F021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The anon_vma field in vma_merge_struct is passed directly to a %px =
format specifier without being cast to a pointer type.
--

commit 642dbe1cf1e7ec576816087b7c56d9a36c41f223
Author: tao <tao.wangtao@honor.com>

mm: switch to anon_vma_tree_t APIs in preparation for ANON_VMA_LAZY
   =20
Replace direct anon_vma usage with anon_vma_tree_t APIs. This prepares
for ANON_VMA_LAZY and prevents external modules from accessing anon_vma
directly.

> diff --git a/mm/vma.h b/mm/vma.h
> index 8e4b61a7304c6..d3bd832992195 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -104,7 +104,7 @@ struct vma_merge_struct {
>  		vma_flags_t vma_flags;
>  	};
>  	struct file *file;
> -	struct anon_vma *anon_vma;
> +	anon_vma_tree_t anon_vma;

[Severity: Low]
Since anon_vma is now an anon_vma_tree_t (which is an unsigned long), does
dump_vma_merge_struct() in mm/debug.c also need an explicit cast to (void *)
when passing it to the %px format specifier?

Without the cast, this might trigger a compiler warning because %px strictly
expects a pointer argument, which could cause a build failure under the
kernel's -Werror configuration.

>  	struct mempolicy *policy;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527110147.1781=
5-1-tao.wangtao@honor.com?part=3D4
