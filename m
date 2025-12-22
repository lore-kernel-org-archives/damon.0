Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84493112AD
	for <damon@lists.linux.dev>; Mon, 22 Dec 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437089; cv=none; b=ID8PjMkelt08j7Tqmb2TtK0yC+f/moSb5GTLtbMMtd9W6XAmtboJVJsUz7SIeIO195lJCkkTWzv48FMOQ6jEeamBJ2bdqRydZp4MdCtvkBPltUQvO9cnnF2Cig+/aPZnL2lT3EhvKO84lu4peNUFoCyVp5COkT4ittGvUS7iGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437089; c=relaxed/simple;
	bh=XMNvolVY9s5LgKowZu+BgLBkEtKG2Ud52uRS7xN9pNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzTsOh8Z6ujQ2awNYPX0Qd/Oow2yuOO818XT4LAi8KZoOr3Mb04yOpHooLpDqbaPwmTnvIqd0aZzDT4oCSWnMMCXp77rm8Tzu7hIRwX8C+TIHpFi+MqaDMhje27H26KPKI8YSjIEiuW/jPWsKEnPAlVboriz86Ikqw/QiiqQWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esxdcOYZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esxdcOYZ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fc174ada4so19760567b3.2
        for <damon@lists.linux.dev>; Mon, 22 Dec 2025 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766437087; x=1767041887; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2JwsXhbVrvin+ouBUUe/Bg2Yvo7yUAk65L8kN39yRc=;
        b=esxdcOYZK2sF17BJ9h2xfwpBQ3DrS50rce6wxDlhsiNYohE6X5bAQiaPSDQZz2Mn1N
         MrXUAh5LMS/GT86ktbrgTfK4vCimyGg2q6EQIJZ+sv2j2LXjMr6DQyK5HsDcV4HbAcUt
         /KeI2wdl9PhGXVr7CW//2lQhlaD8bgbEhQJU/NcmzkBNvROckdQRSjgF3C4jx55D5E2b
         IgEv36A8mlW9xmdScPL81w7WJJwh5hN+0IDKotDfeHFc5ti5olOIGTKQVMaCh85kfUTt
         YhfyILyJ7RMu5AHy3Tu8MpUAKoyLv5eyZP3PQlt2HigZThgJWLHGterLlfil0l3NNOQ8
         8o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766437087; x=1767041887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2JwsXhbVrvin+ouBUUe/Bg2Yvo7yUAk65L8kN39yRc=;
        b=H97flo6eMrb0/59zceEOy+XDro8jpDGX8tjKbFGY2A4Ms9cngDl/zCTnnS/Y71Iv5P
         v92SGLA3jyzJS+3lwDmOfjV8sByjo+j69fTZyXPK9cawj/SugqukwucTO2k/oeOx0Mdw
         N3p7fWjbtNktYnT3Yor1FcLkrhgaSayMXoJzCBigRI6q8IB9PxV1C+2Enio6wu3RvJ/Z
         ZiNfbSZeDEAg6nb+RlLxhd01lJivKsuqz4UUFYKoX43q3poEbERfjdx/gn+vNH+Njd9G
         bg5qFN/5Ua5LitiyNNBT07elomBq3DsmkfNYvqByHa62XBZDHLcHm2IwCz7l9JRoqDx+
         9ZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVHI9HCBxs+vwHJnzwh4x5QkgrH8KSy4VH/ORuPgLGf1DmQqEL4cw46bmiUiSAGufsgSTGJcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG7cwBJwGHZDOWKQK08nbGnfRB+cqe/DfBdcExfgo4yJgxZLjO
	Eea9tlWvjDznTu+SHEaFpI/uwd7vynN+OTTn8rYwow5Th9rUBCZS06CkkJsamQFkyCjg0t8hrjx
	T3X/lW84JyaSp2jAQunLOpVQOxW5MzLU=
X-Gm-Gg: AY/fxX7XZVmSXufhm7pVxFM6WyJ72UWPa7/yxK8hGHGqOjNI4/1jXR0HXVq9fsOhCBQ
	AZeNdos9Htt5al3qfSwxgsKQzGseK6r2dxD8F33Su97FacLqRLN5oyoe/7KFoFq51jugFolfZ1B
	ds6iiGqRBwaC34I1l9gnGWzzhWpV+wyCNHVpNjFmqdwspzXA/Gcjj9G3S2BYuZxnahtfV0Ikmai
	bJDFg2Nss02RYSYwIpmFvcKC8oyh/gVzGMOobcbMfD80VS03Njsif4IJdcZpMMlJ3VatxEw
X-Google-Smtp-Source: AGHT+IF5ZVj6nX1dD8EnmEt0YjgWz+adSjxmOuScYUwkqSyaS9s01jAx5b4fOFRW1VwZtIbeNVqCJx47VZz1WHIZvHc=
X-Received: by 2002:a05:690c:6310:b0:78f:8b7b:7910 with SMTP id
 00721157ae682-78fb4002b0amr103176137b3.36.1766437086616; Mon, 22 Dec 2025
 12:58:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4opA5kdX0c3RrUL0g9e95JJb5hr=ZaGS7FGoQ-nxgF3Q@mail.gmail.com>
 <20251221192751.42586-1-sj@kernel.org>
In-Reply-To: <20251221192751.42586-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Tue, 23 Dec 2025 05:57:55 +0900
X-Gm-Features: AQt7F2pXawDf_RH2SHgy-D6ustF5xP7l5AcTJDceDCDSA83zi1-9LmxQ0aLlvCk
Message-ID: <CAHOvCC6wQ5h5j42iTaepRnSkA6mqeY-ExpHA4Qc6K+-xb6T0eQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
To: SeongJae Park <sj@kernel.org>
Cc: Enze Li <lienze@kylinos.cn>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, enze.li@gmx.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 04:27, SeongJae Park <sj@kernel.org> wrote:
>
> On Sun, 21 Dec 2025 20:04:23 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Sun, 21 Dec 2025 at 17:12, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Sun, 21 Dec 2025 11:42:43 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Fri, 19 Dec 2025 at 21:52, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > > > >
> > > > > > On 2025/12/16 07:16, SeongJae Park wrote:
> > > > > > > Hello Enze,
> > > > > > >
> > > > > > > On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > > [...]
> > > > > If runtime controls are essential, I think using DAMON sysfs
> > > > > interface or DAMON user-space tool is a better choice.
> > > >
> > > > I also think the current DAMON design structure is suitable for DAMON sysfs
> > > > and user-space tools.  DAMON sysfs can run multiple nr_ctxs, so I think it
> > > > would be a good idea to consolidate it into this.  As Enze mentioned, DAMON
> > > > was originally designed as a kernel loadable module,
> > >
> > > I don't recall where Enze mentioned so.  Could you please give me a pointer?
> >
> > Although Enze did not directly state this, His patch is a loadable module,
> > which implies that it was "designed as a kernel loadable module."
>
> Thanks for clarifying.  I understand you are saying Enze's prdm module is
> designed as a loadable module, while you are not saying about other parts of
> DAMON.
>
> >
> > >
> > > And I'm not sure based on what you are saying it was originally designed as a
> > > loadable module.  Maybe you are saying something before DAMON's mainline
> > > landing, but that's quite long ago and my memory management is not good.  Could
> > > you please add more contexts?
> > >
> > > > but I was curious as to
> > > > why it wasn't run that way.
> > >
> > > Maybe I could give you an answer if you could give me the context that I asked
> > > above.
> > >
> > > > When executing the damon_start(**ctxs,
> > > > nr_ctxs, exclusive)
> > > > function, nr_ctxs=1, exclusive=true is passed so that modules are currently
> > > > executed only one at a time.  Therefore, there is no point in running
> > > > DAMON
> > > > as a kernel module, since you are not running multiple modules simultaneously.
> > >
> > > I'm not following your point well.  Could you please elaborate your point?
> >
> > So far in my view, I have analyzed DAMON as follows:
> >
> > DAMON core  <---------> kernel module   <------> damo(user-space)
> > mm/damon/core.c         mm/damon/lru_sort.c
> > mm/damon/vaddr.c        mm/damon/reclaim.c
> > mm/damon/paddr.c        samples/damon/*.c
> > mm/damon/sysfs.c
> >
> > Above, lru_sort and reclaim are DAMON core characteristics, but they have
> > a kernel module structure because they are executed with module_init().
> > I personally think this is inappropriate.
>
> Could you please further clarify why you think it is inappropriate?
>
> > Additionally, currently, DAMON is
> > executed only once at a time according to the exclusive=true condition
> > when damon_start() is called.  In this structure, I believe that the meaning
> > of "kernel loadable module"  is non-existent.
>
> I have to say I still don't get your points.  More elaboration would be nice.

To summarize the Damon I have analyzed so far,

DAMON core  <---------------> DAMON kernel module
| mm/damon/core.c               + mm/damon/lru_sort.c (schemes setting)
| mm/damon/vaddr.c              + mm/damon/reclaim.c (quota, filter)
| mm/damon/paddr.c              + samples/damon/*.c (using samples)
| mm/damon/sysfs.c
            |
        /sys/kernel/mm/damon/admin
            |
            +--------------------------> open/read(get)/write(set)/close
                                               (user-space system call)

The DAMON kernel module above is a sample that sets some parameters of
DAMON.  I think it's better to use damon/sysfs since all of this can be
done in damon/sysfs.  I am continuing to analyze this.  If any
improvements are found, I'll send you a patch.

Thanks,
JaeJoon

>
> >
> > >
> > > > I'm doing some more research into why we run modules with exclusive=true.
> > >
> > > Hoplefully commit 8b9b0d335a34 ("mm/damon/core: allow non-exclusive DAMON
> > > start/stop") will give you more contexts.
> > >
> > > To summarize again, the intention is to avoid kdamonds interrupting each
> > > other's access checks.  For example, suppose the DAMON context for
> > > DAMON_RECLAIM and another one (could be created by DAMON sysfs interface users
> > > or other DAMON modules, say, DAMON_STAT) are running concurrently.  And if
> > > those pick a same page as access check sampling target, their finding of the
> > > access on the page depend on a race condition.  To avoid such a case, DAMON
> > > modules call damon_start() with exclusive argument set.
> > >
> > > Maybe this is unclearly documented.  I will recheck the documentation and
> > > improve it to make this more clear.  If you find the rooms to improve and have
> > > ideas for the improvements, please feel free to send patches.
> > >
> > > > One more thing I would like to add is that I think it would be less
> > > > confusing
> > > > to move lru_sort and reclaim to the samples/damon/ path.
> > >
> > > No, I don't think so.  Those are for real world products, not for samples.
> > >
> > > > And it would
> > > > be
> > > > a good idea to organize the core sources toward
> > > > mm/damon/modules-common.c source.
> > >
> > > I don't find exactly what kind of reorganization you mean.  But I agree there
> > > could be rooms to improve in terms of the files and code organization.  Any
> > > suggestion is welcome.
> > >
> > > [...]
> > > > > > Finally, I would like to add that designing prdm with an extremely
> > > > > > simple workflow -- load the module, set the target PIDs, and enable the
> > > > > > switch -- will contribute to the promotion of DAMON, allowing a broader
> > > > > > user base to benefit from the DAMON system.
> > > > >
> > > > > That workflow is definitely much easier than directly using DAMON sysfs
> > > > > interface.  But, for the reason we have DAMON user-space tool.  Using it, the
> > > > > workflow can also be as simple as prdm, like below.
> > > > >
> > > > >    # damo start $TARGET_PID --damos_action pageout --damos_access_rate 0% 0% --damos_age 2m max
> > > >
> > > > Where can I find the damo source or documentation?
> > >
> > > You could use https://github.com/damonitor/damo and its README.md file.
> >
> > Thank you so much for sharing.  I am trying to analyze the related contents
> > in more detail to improve your DAMON.  I'll try to organize it a bit better
> > and send you a patch.
>
> Looking forward.
>
>
> Thanks,
> SJ
>
> [...]
