Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8B376
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 00:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F17C433C1;
	Wed,  7 Dec 2022 00:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670374586;
	bh=U3rWuYGolopTKgjINqZ0FI0YddZX5cQ+D5E9d0O/2io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqnLsi3capSy+XrNYamv5Of/WCSiRS8EAURCkCFUHs1luC0itxkfsmpqxjhcBISIh
	 QEwGh4rer6U7GTFrR+y+3GKh+FjtQUbk+0hK9cCWVbyv8deIkGP5cnZFBYIregihpG
	 IdMbKPFaLL8SDKit+I9eA7Y82bKbCdjmecZDsTvrAmzg2+MFitMnmtQvomB57ujDTb
	 pcNBDVgd7zYAor4wjF6A3dQnU98p4eXwfpFMgPFLFjCtLkpWZro5wVB7rnWrfcJM6l
	 +p9/yDyhJ2/NaOA5ucnZBvjnRXEc0KIvSSq4yF7wnmVSUz/q/3S6rih3NtkKxbWwbY
	 JnTg2IuYEYWzg==
From: SeongJae Park <sj@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org
Subject: Re: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date: Wed,  7 Dec 2022 00:56:24 +0000
Message-Id: <20221207005624.146281-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207002158.418789-3-vishal.moola@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vishal,


Thank you for this patch.

Nit pick.  Could we please replace 'damon:' on the subject with 'mm/damon:' to
look more consistent with other DAMON patches?

On Tue, 6 Dec 2022 16:21:57 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> This change replaces 2 calls to compound_head() with one.

I guess you mean _compound_head() calls in page_folio() that called from
mark_page_accessed() and folio_mark_accessed().  However, deactivate_page()
calls page_folio() anyway, so this patch doesn't reduce the number of calls to
one but keep the number, correct?  Am I missing something?  If I'm not, I'd
like to clean up the wording.

> This is in preparation for the conversion of deactivate_page() to
> deactivate_folio().

I think folio_deactivate() might be a more consistent naming.  What do you
think?

Also, you may keep the above sentence if you implement folio_deactivate()
first, update deactivate_page() calls to use folio_deactivate(), and finally
remove deactivate_page() definition.

I don't really care about the name and the sequence, though.

> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/damon/paddr.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e1a4315c4be6..73548bc82297 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -238,15 +238,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  
>  	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
>  		struct page *page = damon_get_page(PHYS_PFN(addr));
> +		struct folio *folio;
>  
>  		if (!page)
>  			continue;
> +		folio = page_folio(page);

One _compound_head() call here,

> +
>  		if (mark_accessed)
> -			mark_page_accessed(page);
> +			folio_mark_accessed(folio);
>  		else
> -			deactivate_page(page);
> -		put_page(page);
> -		applied++;
> +			deactivate_page(&folio->page);

And second _compound_head() call here.

> +		folio_put(folio);
> +		applied += folio_nr_pages(folio);
>  	}
>  	return applied * PAGE_SIZE;
>  }
> -- 
> 2.38.1
> 


Thanks,
SJ
