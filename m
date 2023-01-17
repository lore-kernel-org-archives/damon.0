Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFED532
	for <damon@lists.linux.dev>; Tue, 17 Jan 2023 19:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEF1C433EF;
	Tue, 17 Jan 2023 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673982976;
	bh=aYhIaG8n5o0p/BBkpaMa18FYk6ylAOgNMDr8sc9WmPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmT6EUBnqXvnF9/qA9QUrYikLol+V9f38rBhMO8+d3JYmfHgQb/QBhfFgWk30gB5T
	 mIMBlMv9Tk2mGEKXbwFk2Y/tFaSk+CENtRIHyhNrL1AtuaCPkagw6tHWx7jCF39bJv
	 4u2rLBOi73ycfS3m1SZoe0YGQB67+IwT3CgUEQ8wM6MF25C3CigZYFpwKFAqfkd4Rf
	 P+MCQgZUZmmpdo/sonOi+js5YEKH03CgxpValLwJY4s+A6iS8uXkpCo3rHjfJDHD23
	 2VHgugQ5T9bXuDs0ILM+XcFE9jgn0pVcQZXRa0Y4dW+ANgbx/ubxxcvw9Qtb2beM8B
	 0DvGIUS88Miqg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>,
	brendanhiggins@google.com,
	kunit-dev@googlegroups.com,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple tree store
Date: Tue, 17 Jan 2023 19:16:14 +0000
Message-Id: <20230117191614.116521-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117191109.116438-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Jan 2023 19:11:09 +0000 SeongJae Park <sj@kernel.org> wrote:

> Cc-ing kunit people.
> 
> Hi Liam,
> 
> 
> Could we put touching file name on the summary?
> E.g., mm/damon/vaddr-test: Stop using ...
> 
> On Tue, 17 Jan 2023 02:34:19 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> 
> > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > 
> > Prepare for the removal of the vma_mas_store() function by open coding
> > the maple tree store in this test code.  Set the range of the maple
> > state and call the store function directly.
> > 
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: damon@lists.linux.dev
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/damon/vaddr-test.h | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > index bce37c487540..6098933d3272 100644
> > --- a/mm/damon/vaddr-test.h
> > +++ b/mm/damon/vaddr-test.h
> > @@ -14,19 +14,26 @@
> >  
> >  #include <kunit/test.h>
> >  
> > -static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > +static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> >  			ssize_t nr_vmas)
> >  {
> > -	int i;
> > +	int i, ret = -ENOMEM;
> >  	MA_STATE(mas, mt, 0, 0);
> >  
> >  	if (!nr_vmas)
> > -		return;
> > +		return -ENOENT;

Also I think it's ok to return zero here, as this function successfully linked
zero vmas as requested.


Thanks,
SJ

> >  
> >  	mas_lock(&mas);
> > -	for (i = 0; i < nr_vmas; i++)
> > -		vma_mas_store(&vmas[i], &mas);
> > +	for (i = 0; i < nr_vmas; i++) {
> > +		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > +		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > +			goto failed;
> > +	}
> > +	ret = 0;
> > +
> > +failed:
> >  	mas_unlock(&mas);
> > +	return ret;
> >  }
> >  
> >  /*
> > @@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
> >  	};
> >  
> >  	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > -	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> > +	KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)), 0);
> 
> In case of the __link_vmas() failure, I think we should skip this test using
> 'kunit_skip()', rather marking this test failed.
> 
> 
> Thanks,
> SJ
> 
> >  
> >  	__damon_va_three_regions(&mm, regions);
> >  
> > -- 
> > 2.35.1
> 
