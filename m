Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7317D0
	for <damon@lists.linux.dev>; Mon, 30 May 2022 05:04:23 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id f21so18477717ejh.11
        for <damon@lists.linux.dev>; Sun, 29 May 2022 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XirfjVzzLTx46Nwwu3/b9HkXUr3i8KCBR76hKC0bJ0=;
        b=DGhV6BHo9SqfMyLJjJ3wu1Uvioz9+CdI8xcclct5k9zkFmC91TC/GcQFrLJtjk+3JK
         Fxl+U4K7mXsZnykWWVzdXkfszUw0iElQsMpT5qlzr2k73LsOyT04ud0ANyOPX9XWRX2L
         Z08pqCkTditNbugrDOtozQj72LnxxWQmacSinPdkdZu7eHp94yxT9a8xn3/zCzIwXg6F
         FHYwXtF5TpiQQ9tGpL9pjo2RYdsQksdw4Co538yxxUfxku3NxhuL3sp5O+RMxoxBzYCR
         ggMDQNmHPVKvbVt895CzU+hBFdgdCzjL36cZ8gCfSrqCS2Et46lAtoL+Fo1gekZbS/lh
         r6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XirfjVzzLTx46Nwwu3/b9HkXUr3i8KCBR76hKC0bJ0=;
        b=ACKcl/60NYqHWBOiH7Mrh4FzH81jlNB5cluAXp+7+Eny2QZSdVcHphXrvD0PelbJPy
         nX1YucQMqKD2HlvUXA0AJxpk9ZqU8nyG+2JEAx6Qi/2QCmAOvcU+aXFHlbkHuIMd+2f/
         C0G7S2jHKP2WqS9Dmowxu/TcBsH0SibmUbETILW0g0YF9qAuAEDilD4QPpgAKEYL06aM
         C5FdrjP5lWQLwp/iXMYjNGRIQm7KK5YTLDU3lJm3tn94qwyjal5Wmx9Lt8x/6mknwIV0
         g8LbFwQMFu85hE1lR2pzhTaf9qzBPNBQ+kGGLG3nOog3pkzyvEjvZ+UPynLHMYMh8pu9
         Lz2w==
X-Gm-Message-State: AOAM531KnXLhkynnBPH/7vnxbaquDcXqUn/Or70mTE4YxoGOjUa6LhWA
	jWO5JmxDQyObGkr/UHKzypDacS1iPNWq09lHmfw=
X-Google-Smtp-Source: ABdhPJxzcsWyiFUNFhiLW9ZBQqLkxaf3fKI1k4l28bbKdikEdXxdXZVuWKK+6Sq/Nt4qfH6wn4CQzCbctovuEx5Xndo=
X-Received: by 2002:a17:907:d17:b0:6ff:2f91:5b82 with SMTP id
 gn23-20020a1709070d1700b006ff2f915b82mr14190903ejc.192.1653887061641; Sun, 29
 May 2022 22:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220427175049.50057-1-sj@kernel.org> <20220529195411.102379-1-sj@kernel.org>
In-Reply-To: <20220529195411.102379-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 30 May 2022 17:04:10 +1200
Message-ID: <CAGsJ_4y+w-i7OhE9Xk94W8p6srkMsVxTFxwb-+8g_ShGPEj5pw@mail.gmail.com>
Subject: Re: DAMON VA regions don't split on an large Android APP
To: SeongJae Park <sj@kernel.org>
Cc: Rongwei Wang <rongwei.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, shuah@kernel.org, 
	Brendan Higgins <brendanhiggins@google.com>, foersleo@amazon.de, sieberf@amazon.com, 
	Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de, tuhailong@gmail.com, 
	Song Jiang <sjiang88@gmail.com>, =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= <zhangshiming@oppo.com>, 
	=?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>, xhao@linux.alibaba.com, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, May 30, 2022 at 7:54 AM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 27 Apr 2022 17:50:49 +0000 sj@kernel.org wrote:
>
> > Hello Rongwei and Barry,
> >
> > On Wed, 27 Apr 2022 19:44:23 +1200 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > On Wed, Apr 27, 2022 at 6:56 PM Rongwei Wang
> > > <rongwei.wang@linux.alibaba.com> wrote:
> > > >
> > > >
> > > >
> > > > On 4/27/22 7:19 AM, Barry Song wrote:
> [...]
> > >
> > > I guess the cause might be:
> > > in case a region is very big like 10GiB, we have only 1MiB hot pages
> > > in this large region.
> > > damon will randomly pick one page to sample, but the page has only
> > > 1MiB/10GiB, thus
> > > less than 1/10000 chance to hit the hot 1MiB. so probably we need
> > > 10000 sample periods
> > > to hit the hot 1MiB in order to split this large region?
> > >
> > > @SeongJae, please correct me if I am wrong.
> >
> > I think your theory makes sense.  There was a similar concern, so we made DAMON
> > to split regions into 3 sub-regions when we don't see advance[1].  My current
> > rough idea for improving DAMON accuracy is making it more aggressive while
> > keeping the monitoring overhead low.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tree/mm/damon/core.c?h=damon/next-2022-04-21-08-31-on-v5.18-rc3-mmots-2022-04-20-17-37#n1053
> >
> > >
> > > >
> > > > I'm not sure whether sets init_regions can deal with the above problem,
> > > > or dynamic choose one or limited number VMA to monitor.
> > > >
> > >
> > > I won't set a limited number of VMA as this will make the damon too hard to use
> > > as nobody wants to make such complex operations, especially an Android
> > > app might have more than 8000 VMAs.
> > >
> > > I agree init_regions might be the right place to enhance the situation.
> >
> > 'init_regions' has developed for the purpose, where user space knows some good
> > information for starting point of the regions adjustment, and thus want to hint
> > DAMON.  Nevertheless, it might not work as expected, because DAMON
> > automatically updates the target regions to cover all VMAs as much as it can.
> > I have posted a patchset for the use case yesterday[1].
> >
> > [1] https://lore.kernel.org/linux-mm/20220426231750.48822-1-sj@kernel.org/
>
> FWIW, the patchset for the fixed virtual address space ranges monitoring has
> merged in the mainline[1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=98931dd95fd489fcbfa97da563505a6f071d7c77
>

nice to know that. Thanks, though it doesn't fix my problem as I am
looking for a solution to
collect precise monitoring data  automatically and economically.

>
> Thanks,
> SJ

Thanks
Barry
