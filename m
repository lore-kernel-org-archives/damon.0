Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50579F2
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312175; cv=none; b=I+FGW0tgXxewVvbS/E/SGF9ckfCY1pd1Wv/3vzS2yfa1hTIWsz1EbsFnfitS9PvZHovMzdsrM/u2CoaTUgkZp5peVy7JWBuxrNDJ5fsnfpMR9w+zDIx1iUn5slACf1ul96I1OXhyVU51ctVSI/ZoDS9V62AVP1XpWmQu5oEvTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312175; c=relaxed/simple;
	bh=9WO7lSz/cAQUGkrK0ItpqjQPLDfLPXspzBnj1IQb2R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMgO3IonTsL43CXmqrNZDYf48tbC4vL7j3jrHYIFqvTXzW1cujXXR8EJUOpY2+d6WbeJ5SpZa3qan0gD92MnISMVojrv0P40dNK7PhaJ/CtucjMgqIX7xWIoBM40DcMTU02GIz+hj+voaPOpbLR63DBPFYJA/EALKfTUKT3M4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5naEjOF; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5naEjOF"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so3497055fac.0
        for <damon@lists.linux.dev>; Mon, 04 Aug 2025 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754312173; x=1754916973; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzefFzSR2vp1aHaFbeKCmFtRjiIwPiVdlyeV3EqbOx0=;
        b=Y5naEjOF1OEtn9Q786OjkCL63+1pYGHo8XbHzG6M2ZOkSj/qsYYRgWYrXR8EqFD487
         Hc7UOfx/3EXktndxVCpb6phSE/x5X/7ZUEBqdjTD9Ze9rt+7h/v/Mggt3OrQWLcE5c6/
         hmHAZpyQDrViwny1VqKgYTwtbq8wkaUNxdgG4NgAz0P5nhuImPWZG4dgd2qqswcv4SvH
         371ualivyuzHFzdZB3/Z2MhJYx+qds9beR+H40jgqBCdUSJO+Y21lpcpN8Pvfnq0zvoz
         xfIFaRP5e1umX8NdhubExK4adWebbE+IOyZCWKlCsRXqUqVaLUuZaYCn3T7mvsIQZiZQ
         9T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754312173; x=1754916973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzefFzSR2vp1aHaFbeKCmFtRjiIwPiVdlyeV3EqbOx0=;
        b=EjxCwuXbBKA9RgDYSO1UJTjyw5F0upa9oUiq1WGf2nKptncCTCFaOBguUvGClxbq5y
         OfXPsyjgon0JMwnsK8OoCowRbSIzCIzqnnklFBH+Uo/3ccgcCA5WY9DLA0pOJnAy2rYn
         uEqbz8goiX19gX59KnGGI4W9AsB14tak7JpF3j7I2uCQpvcS39EPkffEcsQg5FABOYda
         axXTUnZaMI9Tq9AQ+EPxnRSDMXs+9mJRh5QYW72UArY8hotkozVGu+5hbRm/Zop33DTc
         0vb7rSLRPQW/ApvAXAnsRB4x+Ce1mqVEwMcX22SbPdQn9C41WB0c/sHZH3S9BgI99rE4
         Tupw==
X-Forwarded-Encrypted: i=1; AJvYcCXcHv16IYNAJObdwDTb2MraUIQm8IODGC1272vt0yQNsAnI70XfKTNpnOogZXh6IzTIbczDqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFYwQd1Rllvvj01mEJBfS8FaYiGlqqSkXlzpULuBOeZ5MOqNGc
	n03pXIx18TKnjfFzOCdXtQk4PO/lNo7Dj5pdst2evoqDVE0EhUNoowByyiChJNteYfcfzvBQB1Q
	zw34/mNiD815hKUBsmCj61YOPR9ajw0M=
X-Gm-Gg: ASbGncuO9HQXgu+NXJ3gyVs0HADmqeWTycC66GOjc/ZRULv3mb5aMJvjU1yEOz+fd3/
	zxUDuqCh3UI+DKSpeKUJmhJtUQL1tbLaa9JG/dyDUahk+WlGXxiyWTmKffZOXOXbrfSdZm2wlzZ
	VAqB6U+lrM42lgS/nz+mttb8EkiG+KnWE6uv2Z8Kh7YI2Ewbt5aYfdEIEtNj/3b99EKpG59Turb
	Iokr5t7ioFhroU=
X-Google-Smtp-Source: AGHT+IE4MAXVRhZWR5/ebeb8eIMaIzWPZ9dWzpVYsFUc7uLvARKpfKCbXZj4DM6hUdPgWY/tqsU0xiN3pfgH3/Y8hqg=
X-Received: by 2002:a05:6871:4b15:b0:29e:559b:d694 with SMTP id
 586e51a60fabf-30b67a24c4amr5580485fac.32.1754312172618; Mon, 04 Aug 2025
 05:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxME81-oWdDzc6EzCEgHnXDTe_fQT0s8c2YuqMA1EDbDZZw@mail.gmail.com>
 <20250803174235.55846-1-sj@kernel.org>
In-Reply-To: <20250803174235.55846-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Mon, 4 Aug 2025 21:56:00 +0900
X-Gm-Features: Ac12FXwJQkFS4AO-uIft_lx2f5NinOqaKDiIHA_oUIm8Ok9S52t7PU5_Hc2A1hw
Message-ID: <CABFDxMH+pM1QD69FG+4873Q0WLN3sJB4_NDa6vqLjnjAu8n6+A@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 2:42=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> On Sun, 3 Aug 2025 22:22:05 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> =
wrote:
>
> > Hi, SeongJae and Honggyu,
> >
> > On Sun, Aug 3, 2025 at 2:41=E2=80=AFPM Honggyu Kim <honggyu.kim@sk.com>=
 wrote:
> > >
> > >
> > >
> > > On 8/3/2025 2:30 PM, SeongJae Park wrote:
> > > > On Sun, 3 Aug 2025 13:43:03 +0900 Honggyu Kim <honggyu.kim@sk.com> =
wrote:
> > > >
> > > >> Hi SeongJae,
> > > >>
> > > >> On 8/3/2025 1:22 PM, SeongJae Park wrote:
> > > >>> On Sun, 3 Aug 2025 11:03:12 +0900 Honggyu Kim <honggyu.kim@sk.com=
> wrote:
> > > >>>
> > > >>>> Hi SeongJae and Sang-Heon,
> > > >>>>
> > > >>>> On 8/2/2025 1:50 AM, SeongJae Park wrote:
> > > >>>>> On Sat, 2 Aug 2025 01:11:09 +0900 Sang-Heon Jeon <ekffu200098@g=
mail.com> wrote:
> > > >>>>>
> > > >>>>>> Hi, Honggyu
> > > >>>>>>
> > > >>>>>> On Fri, Aug 1, 2025 at 8:35=E2=80=AFPM Honggyu Kim <honggyu.ki=
m@sk.com> wrote:
> > > >>>>>>>
> > > >>>>>>> Hi Sang-Heon and SeongJae,
> > > >>>>>>>
> > > >>>>>>> On 8/1/2025 2:58 AM, SeongJae Park wrote:
> > > >>>>>>>> Hello Sang-Heon,
> > > >>>>>>>>
> > > >>>>>>>> On Thu, 31 Jul 2025 22:22:30 +0900 Sang-Heon Jeon <ekffu2000=
98@gmail.com> wrote:
> > > >>>>>>>>
> > > >>>>>>>>> Nowadays, damos operation actions support more various oper=
ation set.
> > > >>>>>>>>> But comments(also, generated documentation) doesn't updated=
.
> > > >>>>>>>>> So, fix the comments with current support status.
> > > >>>>> [...]
> > > >>>>>>>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > >>>>> [...]
> > > >>>>>>>>>       * @DAMOS_WILLNEED:  Call ``madvise()`` for the region=
 with MADV_WILLNEED.
> > > >>>>>>>>>       * @DAMOS_COLD:              Call ``madvise()`` for th=
e region with MADV_COLD.
> > > >>>>>>>>> - * @DAMOS_PAGEOUT:   Call ``madvise()`` for the region wit=
h MADV_PAGEOUT.
> > > >>>>>>>>> + * @DAMOS_PAGEOUT:   Reclaim the region.
> > > >>>>>>>>
> > > >>>>>>>> Nice!
> > > >>>>>>>
> > > >>>>>>> But doesn't it make confusion about whether this pages out to=
 disk or does
> > > >>>>>>> demotion to the lower tier memory?  It's because PAGEOUT acti=
on doesn't do
> > > >>>>>>> demotion, but it looks "reclaim" includes pageout and demotio=
n together in my
> > > >>>>>>> understanding since /sys/kernel/mm/numa/demotion_enabled was =
introduced.
> > > >>>>>
> > > >>>>> To my understanding, DAMOS_PAGEOUT can also do demotion when de=
motion_enabled
> > > >>>>> is set.  Am I missing something?
> > > >>>>
> > > >>>> Actually no, please see below.
> > > >>>
> > > >>> I'm unsure to what point you are saying "no".  Are you saying DAM=
OS_PAGEOUT can
> > > >>> also do demotion when demotion_enabled is set?  Or not?  Could yo=
u please
> > > >>> clarify, and add more explanations about why you think so?
> > > >>
> > > >> I checked it again and found I pointed out in the wrong place. Ple=
ase see below.
> > > >>
> > > >>>
> > > >>>>
> > > >>>> do_demote_pass in shrink_folio_list()
> > > >>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1122
> > > >>>>
> > > >>>> The do_demote_pass is used here.
> > > >>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L1293-L=
1302
> > > >>>>
> > > >>>> can_demote() implementation returns false when demotion_enabled =
is on.
> > > >>>> https://github.com/torvalds/linux/blob/v6.16/mm/vmscan.c#L350-L3=
51
> > > >>>
> > > >>> I'm again get confused.  Isn't it opposite?
> > > >>
> > > >> The thing is that DAMOS_PAGEOUT call sequence is as follows.
> > > >>
> > > >>     DAMOS_PAGEOUT
> > > >>     -> damon_pa_pageout
> > > >>     -> reclaim_pages
> > > >>     -> reclaim_folio_list
> > > >>
> > > >> In reclaim_folio_list(), it sets "no_demotion =3D 1" in scan_contr=
ol, then invokes
> > > >> shrink_folio_list().
> > > >
> > > > Thank you, this clarifies.  DAMOS_PAGEOUT doesn't demote pages even=
 if
> > > > demotion_enabled is set.  Thank you for enlightening me.
> > >
> > > Thank you too. Glad to hear that.
> > >
> > > >
> > > > So, "reclaim" means "reclaim".  shrink_folio_list() can do demotion=
s when
> > > > demotion_enabled is set.  I hence still don't think this patch is s=
aying
> > > > something very wrong, and how it could be improved.  Do you have mo=
re specific
> > > > change suggestions for this patch for an improvment?
> > >
> > > I would just like to make the term "reclaim" clearer and we may be ab=
le to
> > > define what "reclaim" is.  I think we can choose between the followin=
g two
> > > different definitions.
> > >
> > > Definition 1. "reclaim" includes "pageout" and "demotion".
> > > In this case, we better clarify all the other documents that mentions=
 about
> > > those terms.
> > >
> > > Definition 2. "reclaim" only includes "pageout", but "demotion" is ou=
t of scope.
> > > In this case, shrink_folio_list just do pageout, but "demotion" is on=
ly
> > > exceptional case so we can say the "demotion" escapes from "reclaim" =
logic.
>
> I was thinking in the first way, and apparently I was simply wrong.  Now =
I
> think the second one is more correct, at least for {DAMOS,MADV}_PAGEOUT.
>
> Yet another way to do the reclaim would be memory.reclaim cgroup file.  S=
eems
> in the case, demotion can happen since user_proactive_reclaim() doesn't s=
et
> scan_control->no_demotion.
>
> I didn't read the code, but apparently memory pressure-based reactive
> traditional reclaim logic would also do demotion?
>
> So, apparently "reclaim" can mean at least the two definitions.
>
> > >
> > > We might have to clarify the term "reclaim" for those cases whether i=
t includes
> > > "demotion" or not.  We might have to discuss with other mm developers=
 together.
>
> I think that could be a nice discussion.  Looking forward to.  As I previ=
ously
> mentioned, I don't think we need to have only 1:1 mapping terminologies, =
though
> I have no strong opinion here.
>
> Regardless of terms, I agree there are many rooms to improve on our
> documentation.  At least DAMOS_PAGEOUT documentation may better to clarif=
y what
> you pointed out.
>
> > > Thanks,
> > > Honggyu
> >
> > Because of the above thread, I got to know the details more clearly.
> > Thank you guys!
> > When the discussion of "reclaim" finishes, I'll make v2 patch as soon
> > as possible.
>
> I don't think we need to block v2 of this patch for the discussion.  What=
 about
> adding a note about the demotion behavior on the details comment second, =
e.g.,

I see. That sounds reasonable because we can revisit after the
discussion finishes.

> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -150,6 +150,8 @@ struct damon_access_report {
>   * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PAD=
DR
>   * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
>   * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
> + *
> + * Note that DAMOS_PAGEOUT doesn't trigger demotions.
>   */
>  enum damos_action {
>         DAMOS_WILLNEED,
>
> >
> > However, I want to talk about a slightly different topic. How about
> > adding support demotion to DAMOS operation action?
> > Maybe we can add another action type or change implementation of DAMOS_=
PAGEOUT.
>
> We actually tried to implement DAMOS_DEMOTE, but eventually decided[1] to=
 have
> a more general action called DAMOS_MIGRATE_COLD.
>
> Do you think there are use cases where DAMOS_MIGRATE_COLD cannot cover?

Thanks for your comments. Above suggestion was based on my lack of
knowledge of DAMON.
I tracked linked RFC threads; now I understand that DAMOS_MIGRATE_COLD
supports both demotion or lateral migration, depending on the
environment.

Maybe there could be a new use case, but I think now it's not at the moment=
.
It's just my bad :( let's just skip that suggestion.

> >
> > IMHO, I think we should first check whether it's possible to set
> > no_demotion in the `madvise` -> `foilo` flow we're using.
> > Since I'm still quite new to these things, I'd like to check whether
> > my idea and direction are correct.
> >
> > I can't thank you all enough for your kindness :)
>
> The pleasure is mine :)
>
> >
> > Best Regards.
> > Sang-Heon Jeon
> >
>
> [1] https://lore.kernel.org/all/20240614030010.751-1-honggyu.kim@sk.com/
>
>
> Thanks,
> SJ

Best Regards.
Sang-Heon Jeon
