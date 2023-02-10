Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41F7E2
	for <damon@lists.linux.dev>; Fri, 10 Feb 2023 03:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rs1WJ//qF+XQHelWy/YwIQj2eaAlZxwFXDpZlnE8jIM=; b=sCYgBidaqOCxWEOCsPRVPWZ4L1
	eKkyj1gik1qBri7xQZFfvZHeyWD+oN03Een6dB+Jhfa6rkvSWB1gFPIAatkKbZHZpGlMtBLdk4B9w
	+gevYCBMOmwwR0x1KV+17+KWLOQ8reFaE6MpG7jOBDmB80ElTfU/buQ1uMyEDZizEJVs2VHpziUC9
	EuYvPzwR7u5RdY90W5aI1/652YiHezU/E5rjlOTLy4fmFNYti8/ucs6JqeAM3hDgd3OrUKaHewscb
	FRe/+wLvmhJkhj41p9YTv6wtEPPWKnU4hWfItyy5uuQsW7LGdidOOTC5N2T0RaxqVBAhSJhf8gB8Q
	q/Ou8bsw==;
Received: from [2601:1c2:980:9ec0::df2f]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQK3g-0045To-Gf; Fri, 10 Feb 2023 03:26:44 +0000
Message-ID: <fe4103e4-5a2f-1659-8b4a-23dae807dad5@infradead.org>
Date: Thu, 9 Feb 2023 19:26:43 -0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] mm/damon/dbgfs: print DAMON debugfs interface
 deprecation message
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230209192009.7885-1-sj@kernel.org>
 <20230209192009.7885-4-sj@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230209192009.7885-4-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/9/23 11:20, SeongJae Park wrote:
> DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
> kernel is released.  And, v6.1.y has announced to be an LTS[1].
> 
> Though the announcement was there for a while, some people might not
> noticed that so far.  Also, some users could depend on it and have
> problems at  movng to the alternative (DAMON sysfs interface).
> 
> For such cases, warn DAMON debugfs interface deprecation with contacts
> to ask helps when any DAMON debugfs interface file is opened.
> 
> [1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/dbgfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index b3f454a5c682..e551a20b35e3 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -20,6 +20,11 @@ static int dbgfs_nr_ctxs;
>  static struct dentry **dbgfs_dirs;
>  static DEFINE_MUTEX(damon_dbgfs_lock);
>  
> +static void damon_dbgfs_warn_deprecation(void)
> +{
> +	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).  If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
> +}

Line length of 234 is a bit over the limit.
I think it would be OK to split it at the end of the first sentence, like:

	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).\n");
	pr_warn_once("If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");

or would that [2 pr_warn_once() calls] not work for some reason?

Or even:

	pr_warn_once(
"DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).\n");
	pr_warn_once(
"If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");

although some people might gag at that one.


-- 
~Randy
