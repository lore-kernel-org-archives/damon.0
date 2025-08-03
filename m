Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517361EEF9
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754227338; cv=none; b=pJiO7jl6epGkZlcd1xekEOu1i+TfothxRmHGKilYMD4Cq8/omnvJOECV6gvz5ElOD8ZclMlaKTv0C73tZ2zUZR/d289+KDMzcyhgFJAwBWeE3ELzIVTDGr2RKi5Ql/bl9+gdbjyCLXP/V+rcXRr9GXRTzM4SWM+QCUxKonjkEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754227338; c=relaxed/simple;
	bh=PPnTfl5fxNftO4x2hxC7+OfFdhj16RDgz7wrzOUR2Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch9EKV6UnlOW+2VMppK9k4HLO/jvxKkpUU0D0VzfNRFTiylgPc3OspUKAUIXaa7na4Ew2JVGoi0/79mxXIe6gsBHR0NHHgMpLUpLIVtW2FtdZJus5ipscgcDpFKUsh5eL6HCfr2LDoSATcJnAEq4D0x+VU2g+NMlcKli348HNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GALeXUCa; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GALeXUCa"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-433f787057eso647003b6e.2
        for <damon@lists.linux.dev>; Sun, 03 Aug 2025 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754227336; x=1754832136; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HSB2tvXT9bEvdTAs0YnamquQV41xlFnAe7adfDX64I=;
        b=GALeXUCaIvFWyQN4WVaP4pFuBb1PcBGkpW6tjkodmtBo/eSQwFv1jg0bK6ZFT7+fty
         Q7TdajQkMFekja6Gi9oGEa0KHPIvBxWFl+Gyt81s8ddUluUj3WW1gkpq6DuQNQpcvdcq
         g0652ucV5Z5BIDTUJL8LwJSGKp4w3kYiU8/hKSbHwdPRuaPUM+MOWsMdkbeRzUVFnH+T
         fw7VYVC7jhUn5Izidpdu4OvI/MyXKiiZzoMmm0OLU8VuXotPPKoZ/VHxn1uMXV2zXEkm
         Tv12D0uXuxINB2HhWYC+4YuqzSfgmpmRmxHPV7nM7G4x+08yZdurHwD52Srrgf+4fUpH
         1Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754227336; x=1754832136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HSB2tvXT9bEvdTAs0YnamquQV41xlFnAe7adfDX64I=;
        b=JnGH/a+Njt+sCgmOKyYl1o1dKP6HnXK+dPcl0vEAvvRM1KH2io/mj9NVoVg0n7M1uo
         wDeAKE3g/nTPX7u96UIRNzlaSIijsslwTQrfE1E+N1XADsaRtXeY/3+pg+JCjSpzjsk3
         J9iK0WISWoh2FASrfbtNi3Sb4EgRRmTS8y4cO2qI+xQVZfp3pFGgKVSfD9setryCcsOE
         MMfiVXaoNLuMwk2uoEJZlDEX6UNiyNDOhUzZYRsqSxb7fK+xFk3K0/r0uU35zCfpwmVO
         Dc7UfExMohrQg+tbo9os8PyYL7QYZDWnIp+5kgbHdeP4dnSuoEPYX3lKfXbPjFOn+3UV
         OzXw==
X-Forwarded-Encrypted: i=1; AJvYcCUIQf9KZXwJrRFuuFR0cVljzT06fB12YeJTVVlx44yjouV5b4R1pUKkIilMFaA+lQetmAxv+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxPnQqd1WcZFwbAoQoI8MWd/F4Ij76H8m4+t4LA/KX9oSpQRnU
	Zcs5iINb+MRRsnYOKErFGx+DutD+dCkFP1RZWWQEdhcc/fCd4rkiYi1X/ZHy39xdavzML5TT+Wc
	dQz3iAZz++B1I3T3J0MjsPdaVfU1qKPA=
X-Gm-Gg: ASbGncv1ThdEW28WDKkovAn2zQWsNV8Yw390hAyTrjVPoS8TQYNX5eh5aBkZ2RZb6Zo
	y2pbgI4OjDB72iFn22yG/0rOFynCmb9FZCMqdfPGpy6rXThixQX9aNf81aZqxn2Zpu5MO1/fZ8U
	5Q7vZ8aFpReU5oxwZu0li3c19nSLbONt231wEB5Dv5cKTc9KoqnMlrZ73PlIghf6YGm+Q41HnEU
	X4W9J5HqO7ZKXA=
X-Google-Smtp-Source: AGHT+IGn04YesBrvNNzeh//REFv0TT3N2YTD1FoQ5dkwA3yQ5PHDpa/fPvYvxWZgpv2WpkMMcoT2RPLeXDzNoumHyNw=
X-Received: by 2002:a05:6808:1209:b0:42c:702e:bd81 with SMTP id
 5614622812f47-433f025fc53mr3866937b6e.17.1754227336290; Sun, 03 Aug 2025
 06:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250803053028.51309-1-sj@kernel.org> <356d8739-d47a-4d62-bec2-38ce8f4a91a1@sk.com>
In-Reply-To: <356d8739-d47a-4d62-bec2-38ce8f4a91a1@sk.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 3 Aug 2025 22:22:05 +0900
X-Gm-Features: Ac12FXwyv8ipVC1nQL5c1LPsQ9h2YnPsPaEgrC1otEGx9PjzexUCxQucBXAXTfI
Message-ID: <CABFDxME81-oWdDzc6EzCEgHnXDTe_fQT0s8c2YuqMA1EDbDZZw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>, kernel_team@skhynix.com, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, SeongJae and Honggyu,

On Sun, Aug 3, 2025 at 2:41=E2=80=AFPM Honggyu Kim <honggyu.kim@sk.com> wro=
te:
>
>
>
> On 8/3/2025 2:30 PM, SeongJae Park wrote:
> > On Sun, 3 Aug 2025 13:43:03 +0900 Honggyu Kim <honggyu.kim@sk.com> wrot=
e:
> >
> >> Hi SeongJae,
> >>
> >> On 8/3/2025 1:22 PM, SeongJae Park wrote:
> >>> On Sun, 3 Aug 2025 11:03:12 +0900 Honggyu Kim <honggyu.kim@sk.com> wr=
ote:
> >>>
> >>>> Hi SeongJae and Sang-Heon,
> >>>>
> >>>> On 8/2/2025 1:50 AM, SeongJae Park wrote:
> >>>>> On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@gmail=
.com> wrote:
> >>>>>
> >>>>>> Hi, Honggyu
> >>>>>>
> >>>>>> On Fri, Aug 1, 2025 at 8:35=E2=80=AFPM Honggyu Kim <honggyu.kim@sk=
.com> wrote:
> >>>>>>>
> >>>>>>> Hi Sang-Heon and SeongJae,
> >>>>>>>
> >>>>>>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
> >>>>>>>> Hello Sang-Heon,
> >>>>>>>>
> >>>>>>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu200098@g=
mail.com> wrote:
> >>>>>>>>
> >>>>>>>>> Nowadays, damos operation actions support more various operatio=
n set.
> >>>>>>>>> But comments(also, generated documentation) doesn't updated.
> >>>>>>>>> So, fix the comments with current support status.
> >>>>> [...]
> >>>>>>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >>>>> [...]
> >>>>>>>>>       * @DAMOS_WILLNEED:  Call ``madvise()`` for the region wit=
h MADV_WILLNEED.
> >>>>>>>>>       * @DAMOS_COLD:              Call ``madvise()`` for the re=
gion with MADV_COLD.
> >>>>>>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region with MA=
DV_PAGEOUT.
> >>>>>>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
> >>>>>>>>
> >>>>>>>> Nice!
> >>>>>>>
> >>>>>>> But doesn't it make confusion about whether this pages out to dis=
k or does
> >>>>>>> demotion to the lower tier memory?  It's because PAGEOUT action d=
oesn't do
> >>>>>>> demotion, but it looks "reclaim" includes pageout and demotion to=
gether in my
> >>>>>>> understanding since /sys/kernel/mm/numa/demotion_enabled was intr=
oduced.
> >>>>>
> >>>>> To my understanding, DAMOS_PAGEOUT can also do demotion when demoti=
on_enabled
> >>>>> is set.  Am I missing something?
> >>>>
> >>>> Actually no, please see below.
> >>>
> >>> I'm unsure to what point you are saying "no".  Are you saying DAMOS_P=
AGEOUT can
> >>> also do demotion when demotion_enabled is set?  Or not?  Could you pl=
ease
> >>> clarify, and add more explanations about why you think so?
> >>
> >> I checked it again and found I pointed out in the wrong place. Please =
see below.
> >>
> >>>
> >>>>
> >>>> do_demote_pass in shrink_folio_list()
> >>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122
> >>>>
> >>>> The do_demote_pass is used here.
> >>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L1302
> >>>>
> >>>> can_demote() implementation returns false when demotion_enabled is o=
n.
> >>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L351
> >>>
> >>> I'm again get confused.  Isn't it opposite?
> >>
> >> The thing is that DAMOS_PAGEOUT call sequence is as follows.
> >>
> >>     DAMOS_PAGEOUT
> >>     -> damon_pa_pageout
> >>     -> reclaim_pages
> >>     -> reclaim_folio_list
> >>
> >> In reclaim_folio_list(), it sets "no_demotion =3D 1" in scan_control, =
then invokes
> >> shrink_folio_list().
> >
> > Thank you, this clarifies.  DAMOS_PAGEOUT doesn't demote pages even if
> > demotion_enabled is set.  Thank you for enlightening me.
>
> Thank you too. Glad to hear that.
>
> >
> > So, "reclaim" means "reclaim".  shrink_folio_list() can do demotions wh=
en
> > demotion_enabled is set.  I hence still don't think this patch is sayin=
g
> > something very wrong, and how it could be improved.  Do you have more s=
pecific
> > change suggestions for this patch for an improvment?
>
> I would just like to make the term "reclaim" clearer and we may be able t=
o
> define what "reclaim" is.  I think we can choose between the following tw=
o
> different definitions.
>
> Definition 1. "reclaim" includes "pageout" and "demotion".
> In this case, we better clarify all the other documents that mentions abo=
ut
> those terms.
>
> Definition 2. "reclaim" only includes "pageout", but "demotion" is out of=
 scope.
> In this case, shrink_folio_list just do pageout, but "demotion" is only
> exceptional case so we can say the "demotion" escapes from "reclaim" logi=
c.
>
> We might have to clarify the term "reclaim" for those cases whether it in=
cludes
> "demotion" or not.  We might have to discuss with other mm developers tog=
ether.
> Thanks,
> Honggyu

Because of the above thread, I got to know the details more clearly.
Thank you guys!
When the discussion of "reclaim" finishes, I'll make v2 patch as soon
as possible.

However, I want to talk about a slightly different topic. How about
adding support demotion to DAMOS operation action?
Maybe we can add another action type or change implementation of DAMOS_PAGE=
OUT.

IMHO, I think we should first check whether it's possible to set
no_demotion in the `madvise` -> `foilo` flow we're using.
Since I'm still quite new to these things, I'd like to check whether
my idea and direction are correct.

I can't thank you all enough for your kindness :)

Best Regards.
Sang-Heon Jeon
