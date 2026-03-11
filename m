Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B21A6817;
	Wed, 11 Mar 2026 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190945; cv=none; b=h1h0ixXkRzvGossWHWTAkjhkMuintcfhR0klU6lSi8x5V0+j4+HLemxnJ6zYNUIIvm6qxulO8d0oPGcmli2vOMPOG2vuflcHuoXE1T6DVTNk8cu7IA4dNu+gluR2+ty2A8W/I2RzXcAaZWs7x8K2sZpIoUs9xOG7ukkeMt2Q1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190945; c=relaxed/simple;
	bh=we4i7ziZO6kLsqvcAHMYtzXyERLCpQSm8acjuSSDEvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyuYOfxS+V1VaJiFHyEwUsneHnh5N/tDXPeWfuuGfnGDGVONoAY+hoVecd/nJY5ni4hfPkOuPhTj8L2vIev3J38lZlOEH3ve6bpiQGAA5vOovEtSboHuYTx/3d4u3H/+2Rz0Q7ryCH/cU/x6NkwoI8c99XeqH1eb5MC87/z/K9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDJ39niq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDJ39niq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B8DC19423;
	Wed, 11 Mar 2026 01:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190945;
	bh=we4i7ziZO6kLsqvcAHMYtzXyERLCpQSm8acjuSSDEvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDJ39niqZe2VuO/AOLrzUooRI8Kka+AUG+I1QqX+ccRej9XGpX1EbT70usNhhk0WH
	 3Hu1gO3Ih1pLLyIG5cjeuauIWOpNPoeNBimlhBzm5QQn83fZQ4LEjsJahWO3pg2IBG
	 d30nTWCiO7p4rjwOuPX9iWX3LM2+YsfD51tEFGridpXeu1HHs2AId1rxRc/7st1xtH
	 Ry6XiQ2Y6xcEi+GZAo3TlYGrvKP1Xx7rhkNulXHlZxZXAelXAkKYShnmXXZjcV5QWq
	 UENkuT2Noc7TmRmYMZ+/Y3TAjnZ32LzBvpgcmcA4px9sZ9QEMRYqpxH7t9TVwSz9dg
	 zKGepBss2dzGw==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Support for synchrounous huge pages collapse
Date: Tue, 10 Mar 2026 18:02:21 -0700
Message-ID: <20260311010222.90548-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310162420.4180562-3-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Mar 2026 16:24:18 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Please add more descriptions of the change, including the motivation.

I assume the motivation is similar to MADV_COLLAPSE that aims to make
synchronous and therefore faster huge page collapsing impacts copared to
MADV_HUGEPAGE?  It would be nice to make it clear here.  Also, if my assumption
is not wrong, adding a test results showing the benefit of DAMOS_COLLAPSE over
DAMOS_HUGEPAGE here would be nice.

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> ---
>  include/linux/damon.h | 1 +
>  mm/damon/vaddr.c      | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a4fea23da857..a9cf17b9e8fa 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -142,6 +142,7 @@ enum damos_action {
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,
>  	DAMOS_MIGRATE_COLD,
> +	DAMOS_COLLAPSE,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>  	NR_DAMOS_ACTIONS,
>  };
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 729b7ffd3565..36791a9a1094 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -969,6 +969,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_COLLAPSE:
> +		madv_action = MADV_COLLAPSE;
> +		break;
>  	case DAMOS_MIGRATE_HOT:
>  	case DAMOS_MIGRATE_COLD:
>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
> -- 
> 2.43.0

The code looks good to me.


Thanks,
SJ

[...]
