Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8C26AC3;
	Sat, 13 Jun 2026 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309244; cv=none; b=pPnKXbcbeYWfroctPNNeGe8fJAItPjIQIsI/MaWw2QLIU17saZ9rd4HzinrkhOCsvdd3NUTOJsFbDfDa9NDp/R3MMhr49rpjy1N7g4MFVSZZ4VSgyhOl+LmvWlNZ7jA3Lm/xVc4ILcAjNpw8ZxnJEv41jh5YFoxAkAt9u4s+8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309244; c=relaxed/simple;
	bh=tHvWZi81LxL7F+MVpu+6EzMYJZ3O1l+hICz7ECFHX6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfcOQ8kUCLlREG+CtI+8q4MjR0JmA3gXQtw2A66mDSQqOBAGPFN/Y2Q8+fYIdQ/HQoaJCdNfuIe5pIoACxw9qSUs6agQ8yirww0cNJ8xBBpVwJU9WOJ9Ia9KSK5Okl7gtS/FAPz59Uhb19xdnH8qbM7w3it/V7MHbGvfcgqp3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4Wm3GNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4Wm3GNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9AC1F000E9;
	Sat, 13 Jun 2026 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781309243;
	bh=MkKGFEfo2wSeteTIcFbVVVFve8yf+zHDN0CBBmfXkas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4Wm3GNssACa6HXiF6MfmVDGQj1E7ufqD9nXT5UF7gFakuXuTOo+f/54/1NjyXJ/T
	 9eaUsP+Of8fH1uSNMe8m4v9KyQYqT1tB2B9YIeF+aRu6Bn9J+cvJEqiChutD0YtFxN
	 MI+70a/5kY0R44v1Oq3/8TmoS6px7UVOsZ9OgrrCBhBQqUC0UP5/rAsR+9SiqHK7SU
	 p94LJuAQNqRLtLwCJ6sEXM8mVB6//enY+oUFfSlrD+B2NxHhAetx/nkXypRyKu3KjX
	 Coy0SKU8YP2mgZW/1Yvw2SMnkqC7aZL1cFZA6pepmFiBlDksuNZrGWHWpbuv/bb1UK
	 C+yhkw4nQrqHA==
From: SeongJae Park <sj@kernel.org>
To: Shardul Deshpande <iamsharduld@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] treewide: fix transposed "sign" typos and update spelling.txt
Date: Fri, 12 Jun 2026 17:07:14 -0700
Message-ID: <20260613000715.791-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612181633.734458-1-iamsharduld@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jun 2026 23:46:32 +0530 Shardul Deshpande <iamsharduld@gmail.com> wrote:

> Several comments and one documentation file transpose the letters in
> "assigned" and "unsigned", spelling them with "sing" instead of "sign".
> Correct all of them.
> 
> Of these, the misspelling of "assigned" is not yet flagged by
> checkpatch, so also add it to scripts/spelling.txt.
> 
> The remaining matches of `grep -ri singed` are RISINGEDGE register and
> enum names, not typos.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
> ---
>  Documentation/mm/damon/design.rst          | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 +-
>  drivers/gpu/drm/drm_color_mgmt.c           | 2 +-
>  drivers/scsi/elx/efct/efct_hw.h            | 2 +-
>  drivers/scsi/isci/host.c                   | 2 +-
>  drivers/scsi/isci/port.c                   | 2 +-
>  drivers/scsi/isci/port_config.c            | 2 +-
>  kernel/bpf/helpers.c                       | 2 +-
>  scripts/spelling.txt                       | 1 +
>  9 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index afc7d52bd..899ac9c69 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -140,7 +140,7 @@ as Idle page tracking does.
>  Address Unit
>  ------------
>  
> -DAMON core layer uses ``unsinged long`` type for monitoring target address
> +DAMON core layer uses ``unsigned long`` type for monitoring target address
>  ranges.  In some cases, the address space for a given operations set could be
>  too large to be handled with the type.  ARM (32-bit) with large physical
>  address extension is an example.  For such cases, a per-operations set

For the above DAMON part,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
