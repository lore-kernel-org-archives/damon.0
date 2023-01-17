Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D2EB18
	for <damon@lists.linux.dev>; Tue, 17 Jan 2023 22:20:42 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso314833pjf.1
        for <damon@lists.linux.dev>; Tue, 17 Jan 2023 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lSGOsJAtpiNhXze0eb7NkEGJHEgCM3o3h68MxeurWOQ=;
        b=d21qx3XZ6vWnpM2uMNOpnaDrS6JFYZLqsPmQZR4rEDpPNDTK7CxWECLavKnY5flXhE
         xYn3PSdRgFwFcUMkYcOEnDq3GHlWRS49qWlUXrbUqbvIH0yCw15L6qX0Z0C94FHLKOkc
         VvFcZS93yqCWJXeQtYmHhWSxuVqHgPxtrcq7aaxyIoZJVF4uLEpeizfgCV+lD2wyjlno
         OT6u3A6pd+rbjY8jz41OW/xfuyUQV1LORUTY9ehw+XngDyK2N6nDiauJ67MVNuXg3oWL
         Kwnw8HaQavzOcd85p16aGf4pQ+7HlvzaCHiW/NewsYN2nc4MXSXIaVdSXzsZaeFyzTxa
         Hi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSGOsJAtpiNhXze0eb7NkEGJHEgCM3o3h68MxeurWOQ=;
        b=QgFFrp+WAv6HIkGgpXL0NuH5ai//cA3TsbYa4rDBRNsCv5QoropbUZAuDUPCmMEwMl
         AHyslbMVxpmzyu4ITIi3/1F9anq1RkQ49++GZR2hOcyGbtTm5OXf3hBCrqk/3zKpMwCw
         Fk/E6f+SJEM6X+cHTIP9td9VMccaVoGh1fLWaFd5uo1shGAMrR8Y9cUsMmJypmAbKCiB
         0NB5MGT6GYToR8D2NgRSyY8nklYkQfFR3Ecwrc5UQWyri26/WMnGli9uZL81wwKGWwlI
         AgkZcEsBNc9bMVIKekPhiJ2kxDaqWyI9X+5xEsH2qIuLvk0WiNTELofA7+X6Ul1CzpBT
         QUjA==
X-Gm-Message-State: AFqh2kpm8EeEMndgecNY8gDnawZ7MF1NKVkWmpahyC+NmmELaA2ON/q/
	SjD5/RkaS0L+9kRa5P23q/IjTRBwgnU+N37Bp8cpHA==
X-Google-Smtp-Source: AMrXdXv1tNSDA/vdVXrwznsUrTfJP5P5q4ykJ1GIOQkYbHKQCS2WJEk7FEHpnkKj40mxqilmHFwVqHlzOhVZdPBqT8w=
X-Received: by 2002:a17:902:d506:b0:193:3760:1ca3 with SMTP id
 b6-20020a170902d50600b0019337601ca3mr310680plg.98.1673994041426; Tue, 17 Jan
 2023 14:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230117023335.1690727-31-Liam.Howlett@oracle.com> <20230117191109.116438-1-sj@kernel.org>
In-Reply-To: <20230117191109.116438-1-sj@kernel.org>
From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 17 Jan 2023 14:20:30 -0800
Message-ID: <CAGS_qxru93E+=6nD31=8UGS=7ADnb3VG3hv=hfh-R1zVcqTJ3w@mail.gmail.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple
 tree store
To: SeongJae Park <sj@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>, brendanhiggins@google.com, 
	kunit-dev@googlegroups.com, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 17, 2023 at 11:11 AM SeongJae Park <sj@kernel.org> wrote:
>
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
> >                       ssize_t nr_vmas)
> >  {
> > -     int i;
> > +     int i, ret = -ENOMEM;
> >       MA_STATE(mas, mt, 0, 0);
> >
> >       if (!nr_vmas)
> > -             return;
> > +             return -ENOENT;

We could pass in the `test` object here and give more detailed info, e.g.
  (if !nr_vmas)
     kunit_skip(test, "...");

And below could be

bool stored_all = false; // instead of ret
...
for (...) {

}
stored_all = true;

failed:
  mas_unlock(&mas);
  if (!stored_all) kunit_skip(test, "failed to...");

> >
> >       mas_lock(&mas);
> > -     for (i = 0; i < nr_vmas; i++)
> > -             vma_mas_store(&vmas[i], &mas);
> > +     for (i = 0; i < nr_vmas; i++) {
> > +             mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > +             if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > +                     goto failed;
> > +     }
> > +     ret = 0;
> > +
> > +failed:
> >       mas_unlock(&mas);
> > +     return ret;
> >  }
> >
> >  /*
> > @@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
> >       };
> >
> >       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > -     __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> > +     KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)), 0);
>
> In case of the __link_vmas() failure, I think we should skip this test using
> 'kunit_skip()', rather marking this test failed.

As noted above, I'd suggest we also pass in the `test` object to
__link_vmas() and call kunit_skip() from there.

>
>
> Thanks,
> SJ

Daniel
