Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0559173
	for <damon@lists.linux.dev>; Mon,  3 Oct 2022 06:37:23 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 129so8923998pgc.5
        for <damon@lists.linux.dev>; Sun, 02 Oct 2022 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MM3OJd2DkcOHrT8hY2BhMYId7OB8ssT+2cxJxle8wTM=;
        b=UoqIh4mYVXhdXCLGpAvavbSbntQUgV4mX1abT4uIHiPoU+ypze1Qhikf2amHuFIC5C
         2S73HE6ZapCgyzkChwrj9UUHStxr+Enp/VpIN/QU7ticyxEOGPTrzrbhZnb1i2x426zg
         QLKJQZbXFJBRRf3TfHTMwpAKUhbVA4aYws5Dmj25iOsDBK+ZP9E2W65JIzArYNuQvaOl
         2wQhvululLm6CD2EKzJgm+1bq/brgt+3HvRGCaDpCfkKpo1V4gM44Hkqsm6910lWW3S/
         7jTxRidVytX6eDUSsmHcTjtoQIPT5U8UXxi83QwWcxmCQuwkQVp9OwQ3/LFdUJ382XVi
         wnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MM3OJd2DkcOHrT8hY2BhMYId7OB8ssT+2cxJxle8wTM=;
        b=HIn9PGrpJ3fqvbT8BlwbaWxYvdCwzRiTYZF5pXp+Q9K1X0wH0h77wSBdEEPsExQ+An
         Q5UknlXdImZdYTptUZijZNB/dv+RDu1TkERamrtMY24cTQ2ROy5Rfl52yN8L+X62yHat
         xm76xZmpISkgL9sWvlkORWDSeXadoxhgh1r26DUJi/TENavQV2U59Z0HQHNKAhX9NNBp
         9aA9igx2C4NDTGdmYuAOVxJ8LLnNIr1vh8/cgRc37gWYtawmnEI3ut31VJ+jZB7CkE7/
         LgcUcw4yYnlbYyiAK3tY4WfwvYJ4p+5pvkzRXnu8/PTaASozI2Xc9chr6qTD6/7WHg+M
         aMuw==
X-Gm-Message-State: ACrzQf21bpdQFhUbrtOjO7Yl/dGXSKhjyPfLZS49nLish5RvH/RD7Ise
	m9ehB/9/ARDY/qjmuGk+F1MgPabph5rZ9V0M
X-Google-Smtp-Source: AMsMyM42oEG5zL1y9xge2FBM+Jd8CA7E5enuQ9pI06q9TlUAB2JE4ijLYyitVK/Pdybwzv/mI9Jnyw==
X-Received: by 2002:a63:20f:0:b0:439:c92f:e6d1 with SMTP id 15-20020a63020f000000b00439c92fe6d1mr17410097pgc.334.1664779043226;
        Sun, 02 Oct 2022 23:37:23 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902a38f00b00176acc23a73sm39844pla.281.2022.10.02.23.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 23:37:22 -0700 (PDT)
Date: Mon, 3 Oct 2022 15:37:18 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, damon@lists.linux.dev
Subject: Re: DAMON KUNIT test failure in latest mm-everything
Message-ID: <YzqDHs56va/NgHFy@hyeyoo>
References: <Yzk8rfGNTTiU3tH0@hyeyoo>
 <20221002193656.8300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002193656.8300-1-sj@kernel.org>

On Sun, Oct 02, 2022 at 07:36:56PM +0000, SeongJae Park wrote:
> Hi Hyeonggon,
> 
> On Sun, 2 Oct 2022 16:24:29 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > On Sun, Oct 02, 2022 at 01:24:23PM +0900, Hyeonggon Yoo wrote:
> > > Hi guys, yesterday I just built and booted latest mm-everything,
> > > and I got following report from KUNIT test.
> > > 
> > > Environment:
> > > - x86_64, gcc 11.2.0
> > > - mm-everything (tag: mm-everything-2022-10-01-01-55)
> > > - config attached
> > > 
> > > Report (stacktrace decoded):
> > 
> > FYI, below is the bad commit from git bisection ;)
> > 
> > Thanks!
> > 
> > 065530b966a42d63f214ba40427dc8d00345f573 is the first bad commit
> > commit 065530b966a42d63f214ba40427dc8d00345f573
> > Author: SeongJae Park <sj@kernel.org>
> > Date:   Fri Sep 9 20:28:57 2022 +0000
> > 
> > mm/damon/core-test: test damon_set_regions
> > 
> > Preceding commit fixes a bug in 'damon_set_regions()', which allows holes
> > in the new monitoring target ranges.  This commit adds a kunit test case
> > for the problem to avoid any regression.
> 
> Thank you so much for this kind report!  I just sent a patch[1] for this.  It
> should fix this issue.

You're welcome! Thank you for quickly fixing this.

> BTW, please note that the real issue was there even
> before the kunit commit, but the kunit commit was the first commit that
> triggers the issue.

Yeah, makes sense.
Hmm.. Do you think it would be worth to backport to -stable?

> [1] https://lore.kernel.org/damon/20221002193130.8227-1-sj@kernel.org/
> 
-- 
Thanks,
Hyeonggon
