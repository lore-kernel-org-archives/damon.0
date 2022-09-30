Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A815A7C
	for <damon@lists.linux.dev>; Fri, 30 Sep 2022 18:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2CFC433D6;
	Fri, 30 Sep 2022 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664561044;
	bh=HBbYVcvs75oAGjIxPLKiGDrS/lAmgAYEWh80o4c7DwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1R010OMHBKNAGjTeSeoIApHOfQ4ULH6A5Y07XTINnt+5Jh+PEdjRmiAd/8NTLqKO
	 TAwqEoitSYsbV0U5494V4j7MS5yfZYBchOjx50jc787sef9qf9SWpfG8sZ8dy7G6HV
	 6mVhNAu7/5nv4qTuH2BNiL9uaAFIAMm7vru4/azxPVCV+OcKs/jiKHom+QXszb3iHc
	 Tyn8IBsM1BVOirEfnD8e4aVG2PyTCH7kTEWzW+kPe0uP97PfyIjXE0MRq6HNnxKpQl
	 X8hedZmFo1kkRwzKNXJmaU/wbORpZVMspxAH31gf5dWkHYNXba+WZco3uAPfmtHI26
	 qBhNpcKAZJlYw==
From: SeongJae Park <sj@kernel.org>
To: haoxin <xhao@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon: add DAMON_OBJ macro
Date: Fri, 30 Sep 2022 18:04:01 +0000
Message-Id: <20220930180401.67230-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <61df199f-5579-933e-3f11-35f204f93bf4@linux.alibaba.com>
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

On Fri, 30 Sep 2022 11:46:26 +0800 haoxin <xhao@linux.alibaba.com> wrote:

> Hi SJ,
> 
> 在 2022/9/22 上午12:41, SeongJae Park 写道:
> > Hi Xin,
> >
> > On Wed, 21 Sep 2022 11:49:42 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> In damon/sysfs.c file, we use 'container_of' macro to get
> >> damon_sysfs_xxx struct instances, but i think it has a little
> >> inconvenience, because we have to pass three arguments to
> >> 'container_of', and the codes also look a bit long, so there i add a
> >> 'DAMON_OBJ' macro, you just need to pass one arguments, then you can get
> >> the right damon_sysfs_xxx struct instance.
> > Thank you always for your helps and efforts, but I have some comments below.
> >
> >> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> >> ---
> >>   include/linux/damon.h |   7 ++
> >>   mm/damon/sysfs.c      | 230 +++++++++++++++++-------------------------
> >>   2 files changed, 102 insertions(+), 135 deletions(-)
> >>
> >> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >> index e7808a84675f..a3b577677caa 100644
> >> --- a/include/linux/damon.h
> >> +++ b/include/linux/damon.h
> >> @@ -24,6 +24,13 @@ static inline unsigned long damon_rand(unsigned long l, unsigned long r)
> >>   	return l + prandom_u32_max(r - l);
> >>   }
> >>   
> >> +/*
> >> + * Get damon_sysfs_xxx relative struct instance.
> >> + */
> >> +#define DAMON_OBJ(_type) ({						\
> >> +	const typeof(((struct _type *)0)->kobj)*__mptr = (kobj);	\
> >> +	(struct _type *)((char *)__mptr - offsetof(struct _type, kobj)); })
> >> +
> > So, this macro assumes two implicit rules.
> > 1. The caller would have a relevant 'struct kobject *' variable called 'kobj',
> >     and
> > 2. The '_type' would have the field 'kobj'.
> >
> > I think the implicit rules could make some people confused, so would be better
> > to be well documented.  Even though those are well documented, I think it
> > cannot intuitively read by everyone.  Making the name better self-explaining
> > might help, but then the length of the code would be not so different.
> >
> > So IMHO, this change makes the code a little bit shorter but unclear to
> > understand what it does.  And at least to my humble eyes, use of
> > 'container_of()' makes the code a little bit more verbose, but clear to
> > understand.  I have no idea how we can make this code shorter while keeping it
> > still easily understandable, and I think the level of verboseness is acceptable
> > for the readability.  So Nack at the moment, sorry.
> 
> I really feel the need to do that， how about keep it in the sysfs.c 
> file, and change it like this：
> 
> #define DAMON_OBJ(_struct) container_of(kobj, struct _struct, kobj)
> 
> it will feel easy to understand and made sense.

I don't think this is enough, at least for my humble eyes.  My questions for
better self-explaining name and removing the implicit rules are not answered.
After all, I don't think the usage of container_of() is a real problem, though
we might always have rooms for improvement.


Thanks,
SJ

[...]
