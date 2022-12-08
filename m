Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645EA460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6M1aQ6KnOCSgd7LdUk/W3gNkuZ1MlCJmwuYIbc9y/Zw=; b=a6Cu/urGiNjNgt68ztqfWvg3Q0
	73CDwzSLfO63tCS+UoNh4+yKODBlWYPHteF6j+O8wizxNdzAq22LvR+B6Q/6xXRuR5HLIyDLutx9b
	mnW6q+yO7K0ue7pwLh4Lys3hly34Pa/v9tTdUejkVTnKaJ/qEzHLVYtlGGBfI9szPyW89CL88Lc/2
	iKyN6XpEmnWXx6mvsXF12JgkeM0PDTjlfkI3JRV7rgH3iQxXRySzrhFFVEvzuzPrW+9lbgnlJX2cn
	IODE+AhcYz2f/zSlAC+5MHu1FibnfN8GSsgSEzaQriIbTu/9KCrCotQQL8QdH8VZdOYsnfr61dLxP
	GMbS/h7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3NxF-007JlF-FQ; Thu, 08 Dec 2022 20:57:17 +0000
Date: Thu, 8 Dec 2022 20:57:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH v3 2/4] madvise: Convert
 madvise_cold_or_pageout_pte_range() to use folios
Message-ID: <Y5JPrZHOVBV2O+np@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-3-vishal.moola@gmail.com>

On Thu, Dec 08, 2022 at 12:35:01PM -0800, Vishal Moola (Oracle) wrote:
> This change removes a number of calls to compound_head(), and saves 1319
> bytes of kernel text.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

