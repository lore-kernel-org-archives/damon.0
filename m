Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAAEB27
	for <damon@lists.linux.dev>; Thu,  5 Jan 2023 19:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66086C433D2;
	Thu,  5 Jan 2023 19:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672947174;
	bh=EgMjUg/SgTSer8lGkKyb8lKAMLgl0roZnntm9yvxsKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTr2lhO69gTJMzuNEnGSg2lCfR3saYLkD3ZXYywixKzKKRqxBA01HT6pfqzGl6boF
	 MpYs/Y7ZL7ZJt7BVf/TQIyjEgQ6+7RLdNVloWea7+Rea6KWPyvpCsx0XcnRXa0V+qb
	 9zQOqHPo6kMxmtyTulPk80tTV8yrdoM9hTmF1CemwIIkyMkdDvqRaQ2bTRignR+273
	 PvAMOfMWbE5Z2XTwP5X3OpqapXhbLNHWMParTyoS4hRsCrGklqClaPzZ7VQlE5Rkdr
	 CuaQ5bqWL9aWdPB3+YSzHO49GmL17c07RHbEkc/QJ1+QYu8hBrnQgvsETOCnxCY2uG
	 avrzTiCBGx6qg==
From: SeongJae Park <sj@kernel.org>
To: Liam Howlett <liam.howlett@oracle.com>
Cc: "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 26/44] mm/damon: Stop using vma_mas_store() for maple tree store
Date: Thu,  5 Jan 2023 19:32:51 +0000
Message-Id: <20230105193251.112393-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105191517.3099082-27-Liam.Howlett@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liam,

On Thu, 5 Jan 2023 19:16:00 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> 
> Prepare for the removal of the vma_mas_store() function by open coding
> the maple tree store in this test code.

But seems this series is not really removing 'vma_mas_store()'.  Wouldn't it
better to do the preparation and removal together in a same patch series?

> Set the range of the maple
> state and call the store function directly.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: damon@lists.linux.dev
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/damon/vaddr-test.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index bce37c487540..41532f7355d0 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -24,8 +24,10 @@ static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
>  		return;
>  
>  	mas_lock(&mas);
> -	for (i = 0; i < nr_vmas; i++)
> -		vma_mas_store(&vmas[i], &mas);
> +	for (i = 0; i < nr_vmas; i++) {
> +		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> +		mas_store_gfp(&mas, &vmas[i], GFP_KERNEL);
> +	}

On the latest mm-unstable, vma_mas_store() uses mas_store_prealloc() instead of
mas_store_gfp().  Seems the difference would make no problem to this test code
in most cases, but could I ask the reason for this change?

Also, should we check the return value of mas_store_gfp()?

>  	mas_unlock(&mas);
>  }
>  
> -- 
> 2.35.1


Thanks,
SJ
