Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5097462
	for <damon@lists.linux.dev>; Tue, 20 Sep 2022 16:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F7C433C1;
	Tue, 20 Sep 2022 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663691145;
	bh=C5q9Co4NCMuDWPDIy18NIrRPLs3YS6viqEBkhpcXokQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiaGdfdNgWNjjYzCY6GxYsbSlhht8rThCwesmppTQNpo45yEPuKZT3YP+DH7EpmOV
	 O7ecbuOfGcphHr6PzBdqARarUtJ6BqO/Z9PTEWTKTDiF6eqNxL90yP6ZFKAkbBNprM
	 LnSN90j4IMgOj5LgOusVTodVjxIw0EJqmrw/u/vZt/enEjQJEqrlKdjD4eFPv2O/c6
	 3HQkFPLWZq71ARTjrJDa2xnHBp/RBtJUEgqgf9CKjIgEPEWH8+Trrb03JWaD6KXOwd
	 FtMuad/w00HW3L2gOMgTmBhQsvCjRxMZJRb9uHAHP/K1BTcFok/Wg7GGPI+Whlqr19
	 JzjF+edCspwoQ==
From: SeongJae Park <sj@kernel.org>
To: haoxin <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to simplify codes
Date: Tue, 20 Sep 2022 16:25:42 +0000
Message-Id: <20220920162542.52554-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <10f3f03d-e616-0619-cbe1-8515a3d7fc0e@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xin,

On Tue, 20 Sep 2022 09:58:41 +0800 haoxin <xhao@linux.alibaba.com> wrote:

> 
> 在 2022/9/20 上午1:22, SeongJae Park 写道:
> > On Mon, 19 Sep 2022 23:12:01 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
> >> we can use kzmalloc to alloc instance of the related structs, This makes
> >> the function code much cleaner.
> > This definitely makes the code cleaner, thank you.  But, the initial intent of
> > the code is to initialize the fiedls that really need to be initialized at the
> > point, for the efficiency and also for making it clear which field is needed to
> > be initialized to what value here.  It's also intended to make readers wonder
> > about where and how the remaining fields are initialized.
> 
> Maybe the other func like damon_sysfs_kdamonds_alloc() also need to do 
> like this, you can see it return directly by
> 
> kzalloc.
> 
> static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
> {
>              return kzalloc(sizeof(struct damon_sysfs_kdamonds), 
> GFP_KERNEL);
> }

In this case, all the fields of the struct need to be initialized as zero.
That's why we use kzalloc() there.

Of course, my opinion is not a static and concrete rule, but changing mind.
And obviously everyone makes many mistakes and DAMON code has many rooms for
improvement.  I really appreciate for your greatful efforts for that.  But, at
least in this case, I think it doesn't really need the change at the moment,
IMHO.


Thanks,
SJ

[...]
