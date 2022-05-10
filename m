Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB57B
	for <damon@lists.linux.dev>; Tue, 10 May 2022 10:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544FBC385C6;
	Tue, 10 May 2022 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652179472;
	bh=HPlLSWADt6C9GL1GBd7Vat0uR30Gl4GAB1gf2UsAytY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irh/0GvbJAMWtYq3cBWneVEISuY6z9KhJ9sm6cIdXLxa4Wh2vZ2agIDYa1U1ZDNOe
	 5ktpcHyjhOq6AcffXJA07VrPVfML7tNF6kV8243zimvdzp6JDLTjhrZw7kW3OEhAlb
	 uMkIfp/dF9IsrTHgeJwQyLlia4A+HoD9pUtTmB1L3rZjdkgXKHvTkaR71c0bivCxQH
	 vhoeoBeTOVzj2S5Hxk0nmtciBoVUod5pt+DBDR0/WV9U0DXaAaavKhrkqfhVNCtBzF
	 NSg0H2Go8P59h1z8yQPUGLObQOHqz8Oc4PAhxihLRtpzfX4AAe0Xg8XdMCM2+tUfzQ
	 sVMDs4/N1t2Kw==
From: SeongJae Park <sj@kernel.org>
To: Liam Howlett <liam.howlett@oracle.com>
Cc: "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use the VMA iterator
Date: Tue, 10 May 2022 10:44:28 +0000
Message-Id: <20220510104428.152064-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504011215.661968-1-Liam.Howlett@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 May 2022 01:12:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> This rather specialised walk can use the VMA iterator.  If this proves to
> be too slow, we can write a custom routine to find the two largest gaps,
> but it will be somewhat complicated, so let's see if we need it first.
> 
> Update the kunit test case to use the maple tree.  This also fixes an
> issue with the kunit testcase not adding the last VMA to the list.
> 
> Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/vaddr-test.h | 37 +++++++++++-------------------
>  mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
>  2 files changed, 40 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 5431da4fe9d4..dbf2b8759607 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -13,34 +13,21 @@
>  #define _DAMON_VADDR_TEST_H
>  
>  #include <kunit/test.h>
> +#include "../../mm/internal.h"

V9 maple tree patchset has moved the definition of vma_mas_store() from
internal.h to mmap.c, so inclusion of internal.h wouldn't needed here, right?

If we end up moving the definitions back to internal.h, because this file is
under mm/damon/, we can also use shorter include path, "../internal.h".


Thanks,
SJ

[...]
