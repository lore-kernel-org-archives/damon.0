Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A137F
	for <damon@lists.linux.dev>; Sat, 26 Aug 2023 00:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761E1C433C8;
	Sat, 26 Aug 2023 00:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693011289;
	bh=KunlMoFaeB09wWpK/chJYbgKS5tfp+/UPw8r6E8VtDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSgNX7cYWf2qXdMFCXD0W7Ors9olo5dw9e/ubec5mBKB8+DJR3PCWeflqAWBrUYb0
	 X2o1UjfBWV5qTqbf0R8Lyfjk7WbHr6/e9tZbXrkfFpeHMJIEbFRzSPg/1k6AtNDdPQ
	 sZjVeIQtT4GkUioINsligfhNom5WIP9u9+YfPIfsmYXUjEyvo2EUYYVv3xuLnNyk21
	 hgqTssuXFfgYZNLh61C4bGjExZxsLv6euZ2K/V3DTMdq5nJlvnxrW1MfQtt3V59Tf6
	 k+j1ErQANSDNyg6LyJNEEX4Nd5fsU4uYXW/KhjIVrr6PExmaSUoyfC1xPXi15w2pPR
	 P/ZFZ5u2L4xiQ==
From: SeongJae Park <sj@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qing Zhao <qing.zhao@oracle.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs: add __counted_by() annotation
Date: Sat, 26 Aug 2023 00:54:47 +0000
Message-Id: <20230826005447.109776-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202308251426.94092475C3@keescook>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kees,

On Fri, 25 Aug 2023 14:32:34 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Fri, Aug 25, 2023 at 02:04:41AM +0000, SeongJae Park wrote:
> > Commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> > added __counted_by() annotation.  The underlying attribute for the
> > feature is still under development, but adopting it can improve the
> > readability of the code.  Apply it to four dynamic arrays in DAMON sysfs
> > code.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/sysfs.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 808a8efe0523..36a176f38726 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -93,7 +93,7 @@ static const struct kobj_type damon_sysfs_region_ktype = {
> > 
> >  struct damon_sysfs_regions {
> >  	struct kobject kobj;
> > -	struct damon_sysfs_region **regions_arr;
> > +	struct damon_sysfs_region **regions_arr __counted_by(nr);
> >  	int nr;
> >  };
> 
> Unfortunately this isn't supported yet for non-flexible-array-members:
> 
> mm/damon/sysfs.c:96:14: error: 'counted_by' attribute may not be specified for a non-array field
>    96 |         struct damon_sysfs_region **regions_arr __counted_by(nr);
>       |                                     ^~~~~
> 
> We'll have to wait a bit before we can add this patch.

Thank you for checking this and let me know.  Ok, I will wait.

> Thank you for
> getting it ready, though!

Owing to your previous contributions.  Thank you for helping me make DAMON code
better to read :)

> This support is next in line. :)
> 
> The FAM support is likely ready to land, though[1]. I just tested it
> today.
> 
> -Kees
> 
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/628459.html
> 
> -- 
> Kees Cook
> 


Thanks,
SJ
