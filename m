Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066F8C0B
	for <damon@lists.linux.dev>; Tue, 21 Feb 2023 20:10:27 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so6439217pjc.0
        for <damon@lists.linux.dev>; Tue, 21 Feb 2023 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677010227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LRlUY6P+Ws5JPolkKmM4if+5xV6FQbDYkfpB+lRI9nA=;
        b=p7bEe3YtIo4ajQL8acKLCVuOyUPkB9m1s1o0xoenMbSiaB337hC/CdK/jbzvDugc0f
         Hf4fM4xnGQAICvqcdnsCmWG1jh1fCnAzvC+G7PNSr9l4eEyhUf6HRrEVj0qye4Z9xojM
         3HByT4JE1omYdOn463zyimPZ7tXfslxrCjpy4aS4iO1exB1AF66AgiwSzKq/yd1BQ7jz
         cgyX1mzTZe65lBFWhIkW5bB0yaZ01Wz7NEC10t3zZyXHX0uRN7BeC/LOcD2C9HgNWyc7
         rreJcF/ZpBmEDH/OC8J0GurpsNB6TBWV69eZWIhvxd8szuQUilaJvRL9jPxKLNWOipXz
         1wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677010227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRlUY6P+Ws5JPolkKmM4if+5xV6FQbDYkfpB+lRI9nA=;
        b=Um7hcamJpiNKFmXxiiJ2IYlubWm1XnTON56XBU/bQRmKjl8th7P2WhiPpTkXt5MzAr
         HgYoI8c8vSfRGEkC7Y6zy2Sr0OY+2Sz7lNlEuTFM6ZmVSRwu0q8oZp/GbbYGCbxF8OvX
         QFa4P42JWnmDV+N1xCcaj43SwApYkdNdIBETAdT63GCdk972UgNZOpsLqBTs6YMf72V6
         XbtlE3klVikZgzlebvOGRsGFJ5q//Lt2br+wYkKS5Nfs0m6N0lZZvFvu3GRlYewjcWNT
         iwlUJzsV9l4OrEbYqgUzo9I+PyygEFaPU7FipmLwu/DVUdgxAiGAdQzzFTI1OhEL5v0e
         6FyA==
X-Gm-Message-State: AO0yUKVhEkxOMzJ6WJ9Nq05fjEWHKBbarse2ul148p45gLg4frwGClj2
	29Us1BEvVQAcdkwUu/dxJue9igJSlOFhNysYan/qRcZrgl9tz8Db
X-Google-Smtp-Source: AK7set/bvzuBBHiSVRwjdCBYFgmcLi2VbO8gyb1hmLmDfOqhiJPx1AXSbHElEgZn5ThzkdRg0ezGAHgn6PJB0Lpc+wQ=
X-Received: by 2002:a17:90b:48c3:b0:234:bd18:61e4 with SMTP id
 li3-20020a17090b48c300b00234bd1861e4mr2124639pjb.83.1677010226892; Tue, 21
 Feb 2023 12:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230221070837.1502935-1-anders.roxell@linaro.org> <20230221171951.131472-1-sj@kernel.org>
In-Reply-To: <20230221171951.131472-1-sj@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 21 Feb 2023 21:10:15 +0100
Message-ID: <CADYN=9KdXbCbVCs1C5n54g_EtmTn5iuHwh3BC4drHtAvcOQ0XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: damon: add config file
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Feb 2023 at 18:19, SeongJae Park <sj@kernel.org> wrote:
>
> Hi Anders,
>
>
> Thank you for this patch!
>
> On Tue, 21 Feb 2023 08:08:36 +0100 Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > Building and running the subsuite 'damon' of kselftest, shows the
> > following issues:
> >  selftests: damon: debugfs_attrs.sh
> >   /sys/kernel/debug/damon not found
> >
> > By creating a config file enabling DAMON fragments in the
> > selftests/damon/ directory the tests pass.
> >
>
> I think we could put Fixes tag as below?
>
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")

Make sense, I'll add it.

>
> Though this may not need to be merged in stable.
>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/damon/config | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >  create mode 100644 tools/testing/selftests/damon/config
> >
> > diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
> > new file mode 100644
> > index 000000000000..a6b636e438b9
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/config
> > @@ -0,0 +1,8 @@
> > +CONFIG_DEBUG_SYSFS=y
>
> 's/SYS//'?  Or, I guess this is not needed at all?

This can be dropped.

Thank you.

I'll respin the patch shortly.

Cheers,
Anders

>
> > +CONFIG_DAMON=y
> > +CONFIG_DAMON_SYSFS=y
> > +CONFIG_DAMON_DBGFS=y
> > +CONFIG_DAMON_PADDR=y
> > +CONFIG_DAMON_VADDR=y
> > +CONFIG_DAMON_RECLAIM=y
> > +CONFIG_DAMON_LRU_SORT=y
>
>
> Thanks,
> SJ
>
> > --
> > 2.39.1
