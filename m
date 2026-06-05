Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC03E4C6C
	for <damon@lists.linux.dev>; Fri,  5 Jun 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653384; cv=pass; b=RK+TQFOZmSpdIIxjIpGf+Sw6vGH9sbPA33jUXjQvazXn7xyrMthOc8NSC3Wm96FY5M9Ayp9csgM9Y+8R+KxnOLX9yqDUzBE22M9AYaZsc6ONq3PtUtezUln9CGahABvw7pOm/cVkMCljd18W7NW0erAiFvHEEOPsvMHIkv8C/Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653384; c=relaxed/simple;
	bh=fXfXk/1LzHnPDWmujicyJbX/mcKGT50kFcQZFxYNjEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5q1EX4UdRNr2IwCu60yQg4frhq2VmX3BYAi6wZSExwBmQp1xlXDJlUH4fPDEvrECtqvdEJUya6QSMupBDYUUWTrR8ypQhhsn5dZtPpIQV2RJbMeP2qNAutAS7eC8FRHaihsmhNZ4Cuf2mYdQPS7x88NjHGeQyvYeuY6+ty81+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxo6+3Hs; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxo6+3Hs"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6c7e72a6bdcso62896137.1
        for <damon@lists.linux.dev>; Fri, 05 Jun 2026 02:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780653382; cv=none;
        d=google.com; s=arc-20240605;
        b=lRMrVCjOm8OpYniion8LlOq8Fo7gJUxcO8xb8rGoDAEgLSAWMLDrFNkFR4SO3WfiAj
         MQIJqLSzD9UhlP8jCPKw9Qnt/CLKrXTKW6lavCDBbZpHWB0pFv/aMovd5i5v+qKQkZC4
         wlZwowp0bXoFPB/OIG8bOuGRxCXhfnnCFxZXYUtecDM4SLXVA86ZVg69AiMbjhT6s0eb
         4VqnK3iHFtHvDc1AmkqtZtbqZyTlt0hDdL611rXCi0dqLztxk/g5fqIEzN7LMycNIhvu
         KKayNsUgFEg2KE1djgDM6nuPY07mCRy/C+5OTYwLGRNFc1z9R/fMrjc0AGaoN76LhK33
         7OpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=188nvOnCtn3gvAkEJ5AAqju2IjEOtnXumuNth0RPW38=;
        fh=6a3aAaUxbtpNoT/f8W8thaEPTmK1+71+dD3MQn0vnx8=;
        b=jxxqCG9T7u5p+1GcIvVxc8ru4lu8fNl69f0iE6S+xWuopRR+XEjC4Qdsi7yYHpUpnA
         WBIgrVmfvpCSPfYRcsYS18PhFE7cQExBNRWPBXL4L0wD0a7Y7VdiASwxMpQNbNH3log9
         PsomjauNKtxeRAdZLl+2snIC7wS4DfiMWcLKjRgjqcnqpfUjYEyuHxPHaompU4n321ES
         hG15dlz5fmWlPaXemdaNbo58oCt/wIdJAYrJoU/7r4+zHfzDp9pcoHHPyQenL43TIcvF
         eUHSyaEIune0xWQQBAk7yxNAECodGVbigCSb/cDSvK5g+xJ6tlX68fWb35In35rkaZzo
         6BLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780653382; x=1781258182; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=188nvOnCtn3gvAkEJ5AAqju2IjEOtnXumuNth0RPW38=;
        b=Pxo6+3Hsx1Tlu7bpLIbW0fdGihLa2Fiw/xz2hov7SkAU7ToDnz8x0yowjgDQxT2+w9
         CoiARKnQ1eKsi7XmD6EJm4rw7ox5+T4BckZ7Pkq5j7Ja+ajg/BrP7KuKjCR8KgCUK3sa
         2u8W3j9Y9tQl9m4Q4JMVJ7wh4gOEpLj12OM4vjk1pWdhzexEMOaJlKXE+DxfYzsikTI5
         6DWVGN/A4mOJAsQMGa7F0DW6KyQ8gRRS9kVrMWJgham/W0i93/BfZAcXEP8YF6Yd9ATn
         RQVYm3zv5zvFUmspIgKvxbf3hjgtXRfHDGlQqw/PeT/87z1lbAgr3qWHiagnJlav3BH3
         XaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653382; x=1781258182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=188nvOnCtn3gvAkEJ5AAqju2IjEOtnXumuNth0RPW38=;
        b=exuSlT+fRpvmMmQEh5WAWvUao0Q5Qa/1bQABogGZ1ka1QIN8CAXVK5UGhdZCxX67zb
         Pxb0SmEFCt3kdCiSeQsi9cuz1aKxBVuQPhgxALD2KpOW3O5JXtPELSBgIrT4NAWeeYZn
         rBaea4IXRnIpsm9oVwyx1w5s+nPDexLy5S+1z1wctRGfGoYF9+e3+C71G0b3jZdjnqRD
         W+DUg6sjrAS3j86FbPWfAazykqtQUaTac7AIyJbB3EnjrStr/UV6sypvLU5VAXajV3t6
         6qPhYGVum6ou+M1KFAMTjiz3fdjNmEUC9crce5PIXSPe7IhhYLQb7yd4d+GGxrU2BEEW
         bm6w==
X-Forwarded-Encrypted: i=1; AFNElJ/MJ/uBVrAj8bW1gwKzgn6L0WFCTiJWckEGpgV58GAn+6qNt3cn3I4YcfUtRju7vFcPcnxZfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPG8EnBjpsgg7WdfkiEGDD9QbTmJewKXPGnZS2iFHMwavr6TiL
	GD/1A6c2260BhZymb5NteK4BdArpRvkBhUYff4VxSK2DyO625uCM3c4o8Sivsy5DZ75JtdrGUFD
	wPPS+ImI9OCA3Jq7hJ+fiB89XhgVkk2g=
X-Gm-Gg: Acq92OGb9GAjv/bphoYJNOcsIEp3Yd16rRsAO5qkJEQy2jFk3p7sKVAWEXUMtkY8REm
	2i8yovE2IIb1M81xkcxLsmsVu58BhfBDrbpR4Qbdmpo+EYzcdD/Rl3ZbvOdoyv4fvQddLfe045T
	3l5ujZqbRle/QFbqVjp6kzF5rbnRhDNZh8xucNiGZ9cTtQctyvrlrffkT0m7YfWUUBGQV7MkJAI
	OCnMPhZohO1dW+Esm76Lu7DrCWFMvJz2xRLha9/NnSNe2pLprj+tueTHTa1HGbCD55SHwoDjVyF
	UlFtxiDOf1hI7wlaux/C41r+vx6P
X-Received: by 2002:a05:6102:c50:b0:60f:77ad:4bed with SMTP id
 ada2fe7eead31-6fefdee6cd8mr293230137.7.1780653381899; Fri, 05 Jun 2026
 02:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260524100258.36819-1-saileshnandanavanam@gmail.com>
 <20260524183750.1810-1-sj@kernel.org> <CAF+TLO0TOKr3nef9RnbBuZ8A-jNpV1po26t1BO6JbSqMhfABvw@mail.gmail.com>
In-Reply-To: <CAF+TLO0TOKr3nef9RnbBuZ8A-jNpV1po26t1BO6JbSqMhfABvw@mail.gmail.com>
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Date: Fri, 5 Jun 2026 15:25:48 +0530
X-Gm-Features: AVVi8Cd8y5fFKwqGfXRah25YurCGU1j0bkf9HlQz8Xf8QOU5lKc-yuHMMmkRebY
Message-ID: <CAF+TLO0=zpnAo-Ma2zi-Op=P0w0TPVCLbBkWKq113RDsHaCXuw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/damon: add regression test for damos_walk()
 vs kdamond exit race
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

Apologies for the delayed response.

Thank you for the detailed review and for actually testing the patch
on a kernel with the fix reverted.

You are right that the userspace selftest cannot reliably trigger this
race. The race window between kdamond cancelling requests and
unsetting the pointer is microseconds wide. Since userspace calls have
system call overhead, they cannot hit that window reliably =E2=80=94 which =
is
why the test always passed even on a broken kernel.

Regarding the error condition question:

When kdamond stops naturally, any subsequent write to the state file
(which update_schemes_tried_regions() does internally) fails because
kdamond is no longer running. So receiving an error indicates kdamond
exited without deadlock =E2=80=94 the expected success condition. I should
have explained this more clearly in the comment.

I agree that a KUnit test is the right approach since it runs inside
the kernel and can directly set walk_control_obsolete to simulate the
race condition reliably without timing dependencies.

I will drop the userspace selftest approach and write a KUnit test for
damos_walk() functionality including walk_control_obsolete. I will
verify it fails on a kernel with commit 33c3f6c2b48c ("mm/damon/core:
fix damos_walk() vs kdamond_fn() exit race") reverted and passes with
the fix present before sending v3.

Regarding other feedback:
- Will use correct commit description format with subject in brackets
- Will remove the Fixes: tag
- Will add blank line before _damon_sysfs import
- Will add changelog and link previous versions
- Will share revision plan and wait at least one day
  before sending new version

Please give me some time to study mm/damon/tests/core-kunit.h and
implement this properly.

Thanks,
Sailesh Nandanavanam


On Fri, Jun 5, 2026 at 12:44=E2=80=AFPM Sailesh Nandanavanam
<saileshnandanavanam@gmail.com> wrote:
>
> Hi SeongJae,
>
> Apologies for the delayed response.
>
> Thank you for the detailed review and for actually testing the patch on a=
 kernel with the fix reverted.
>
> You are right that the userspace selftest cannot reliably trigger this ra=
ce. The race window between kdamond cancelling requests and unsetting the p=
ointer is microseconds wide. Since userspace calls have system call overhea=
d, they cannot hit that window reliably =E2=80=94 which is why the test alw=
ays passed even on a broken kernel.
>
> Regarding the error condition question:
>
> When kdamond stops naturally, any subsequent write to the state file (whi=
ch update_schemes_tried_regions() does internally) fails because kdamond is=
 no longer running. So receiving an error indicates kdamond exited without =
deadlock =E2=80=94 the expected success condition. I should have explained =
this more clearly in the comment.
>
> I agree that a KUnit test is the right approach since it runs inside the =
kernel and can directly set walk_control_obsolete to simulate the race cond=
ition reliably without timing dependencies.
>
> I will drop the userspace selftest approach and write a KUnit test for da=
mos_walk() functionality including walk_control_obsolete. I will verify it =
fails on a kernel with commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk(=
) vs kdamond_fn() exit race") reverted and passes with the fix present befo=
re sending v3.
>
> Regarding other feedback:
> - Will use correct commit description format with subject in brackets
> - Will remove the Fixes: tag
> - Will add blank line before _damon_sysfs import
> - Will add changelog and link previous versions
> - Will share revision plan and wait at least one day
>   before sending new version
>
> Please give me some time to study mm/damon/tests/core-kunit.h and impleme=
nt this properly.
>
> Thanks,
> Sailesh Nandanavanam
>
> On Mon, May 25, 2026 at 12:08=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
>>
>> Hello Sailesh,
>>
>> On Sun, 24 May 2026 15:32:58 +0530 Sailesh Nandanavanam <saileshnandanav=
anam@gmail.com> wrote:
>>
>> > Add a regression test that verifies damos_walk() does not deadlock
>> > when racing with kdamond_fn() exit.
>> >
>> > When kdamond_fn() finishes its main loop, it cancels remaining
>> > damos_walk() requests and unsets damon_ctx->kdamond. Without the fix
>> > in commit 33c3f6c2b48c, damos_walk() could be called right after
>>
>> Please use more common commit description format that has the commit sub=
ject.
>> E.g., commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_f=
n()
>> exit race").
>>
>> > cancellation but before kdamond pointer unset, causing it to wait
>> > forever for handling that never comes.
>> >
>> > The test starts kdamond monitoring a short-lived process, waits for
>> > the process to exit naturally triggering kdamond termination, then
>> > rapidly calls update_schemes_tried_regions in a separate thread to
>> > hit the race window. Using a thread with join timeout ensures the
>> > test can detect kernel-level deadlocks where the system call blocks
>> > in uninterruptible state.
>> >
>> > The sysfs state path is resolved dynamically via the kdamonds object
>> > instead of being hardcoded, and exceptions are handled specifically
>> > as OSError rather than using a bare except block.
>>
>> Thank you for this patch.  But, is this test reliable?  I ran the test m=
ore
>> than 100 times on my system running a kernel that has commit 33c3f6c2b48=
c is
>> reverted.  But test always passed.
>>
>> >
>> > Fixes: 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn() =
exit race")
>>
>> This is not fixing a bug in the commit, so the above 'Fixes:' tag is
>> inappropriate and may only confuse people.
>>
>> > Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
>> > ---
>>
>> From next time, please add changelog on the commentary area [1], with li=
nks to
>> the previous revisions.
>>
>> I was able to find the previous version on the mailing list [2], so putt=
ing the
>> link here for others.
>>
>> Also, before sending a new version, please share your revisioning plan a=
nd give
>> time (about a daay) for others to comment about.
>>
>> >  tools/testing/selftests/damon/Makefile        |  1 +
>> >  .../sysfs_damos_walk_kdamond_exit_race.py     | 82 ++++++++++++++++++=
+
>> >  2 files changed, 83 insertions(+)
>> >  create mode 100755 tools/testing/selftests/damon/sysfs_damos_walk_kda=
mond_exit_race.py
>> >
>> > diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/se=
lftests/damon/Makefile
>> > index 2180c328a825..60c83d6c318e 100644
>> > --- a/tools/testing/selftests/damon/Makefile
>> > +++ b/tools/testing/selftests/damon/Makefile
>> > @@ -20,6 +20,7 @@ TEST_PROGS +=3D sysfs_update_removed_scheme_dir.sh
>> >  TEST_PROGS +=3D sysfs_update_schemes_tried_regions_hang.py
>> >  TEST_PROGS +=3D sysfs_memcg_path_leak.sh
>> >  TEST_PROGS +=3D sysfs_no_op_commit_break.py
>> > +TEST_PROGS +=3D sysfs_damos_walk_kdamond_exit_race.py
>> >
>> >  EXTRA_CLEAN =3D __pycache__
>> >
>> > diff --git a/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_ex=
it_race.py b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_ra=
ce.py
>> > new file mode 100755
>> > index 000000000000..8e8006d63926
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race=
.py
>> > @@ -0,0 +1,82 @@
>> > +#!/usr/bin/env python3
>> > +# SPDX-License-Identifier: GPL-2.0
>> > +#
>> > +# Regression test for damos_walk() vs kdamond_fn() exit race.
>> > +#
>> > +# When kdamond_fn() finishes its main loop, it cancels remaining damo=
s_walk()
>> > +# requests and unsets damon_ctx->kdamond. If damos_walk() is called r=
ight
>> > +# after cancellation but before kdamond pointer unset, it could wait =
forever
>> > +# for handling that never comes, causing a deadlock.
>> > +#
>> > +# This test verifies the fix by rapidly calling update_schemes_tried_=
regions
>> > +# while kdamond is naturally terminating (monitored process exits).
>> > +# Without the fix (commit 33c3f6c2b48c), this would hang indefinitely=
.
>> > +
>> > +import os
>> > +import subprocess
>> > +import threading
>> > +import time
>> > +import _damon_sysfs
>>
>> Let's add a blank line before _damon_sysfs import, to be consistent with=
 other
>> test files, like sysfs_update_schemes_tried_regions_hang.py.
>>
>> > +
>> > +def call_update(kdamond, result):
>> > +    err =3D kdamond.update_schemes_tried_regions()
>> > +    result['err'] =3D err
>> > +    result['done'] =3D True
>> > +
>> > +def main():
>> > +    proc =3D subprocess.Popen(['sleep', '0.3'])
>> > +
>> > +    kdamonds =3D _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
>> > +            contexts=3D[_damon_sysfs.DamonCtx(
>> > +                ops=3D'vaddr',
>> > +                targets=3D[_damon_sysfs.DamonTarget(pid=3Dproc.pid)],
>> > +                schemes=3D[_damon_sysfs.Damos(
>> > +                    action=3D'stat',
>> > +                    access_pattern=3D_damon_sysfs.DamosAccessPattern(
>> > +                        nr_accesses=3D[0, 200]))]
>> > +                )]
>> > +            )])
>> > +
>> > +    err =3D kdamonds.start()
>> > +    if err is not None:
>> > +        print('kdamond start failed: %s' % err)
>> > +        exit(1)
>> > +
>> > +    # Wait for monitored process to die naturally
>> > +    proc.wait()
>> > +
>> > +    # Rapidly call damos_walk() while kdamond is exiting
>> > +    # Use a thread with real timeout to detect kernel-level deadlock
>> > +    deadline =3D time.time() + 5
>> > +    while time.time() < deadline:
>> > +        result =3D {'done': False, 'err': None}
>> > +        t =3D threading.Thread(target=3Dcall_update,
>> > +                             args=3D(kdamonds.kdamonds[0], result))
>> > +        t.daemon =3D True
>> > +        t.start()
>> > +        t.join(timeout=3D5)
>>
>> I'm not sure if this is reliable to trigger the exact race.  As I mentio=
ned
>> abovely, I tried this test more than 100 times on a kernel that having t=
he fix
>> reverted, but I was unable to make the test fail.  If it is that unrelia=
ble,
>> I'm not very sure if having this test is beneficial or just make people
>> confused.
>>
>> If the test has no false positive, maybe having this make sense to
>> opportunistically finding the bug.  But I think the 5 seconds timeout is=
 still
>> not very reliable on some case, and therefore it seems false positive te=
st
>> failure is available.  If that is correct, I think having this test migh=
t only
>> confuse people.
>>
>> I think having damos_walk() kunit test for its functionalities including=
 the
>> walk_control_obsolete might make more sense.
>>
>> > +
>> > +        if not result['done']:
>> > +            print('FAIL: update_schemes_tried_regions hung - '
>> > +                  'possible damos_walk/kdamond exit race deadlock')
>> > +            exit(1)
>> > +
>> > +        if result['err'] is not None:
>> > +            # kdamond stopped cleanly - expected
>> > +            break
>>
>> Is the above if condition correct?  Could you please explain why having =
an
>> error here is expected?
>>
>> > +
>> > +        # Check kdamond state via sysfs using dynamic path
>> > +        state_path =3D os.path.join(
>> > +                kdamonds.kdamonds[0].sysfs_dir(), 'state')
>> > +        try:
>> > +            with open(state_path) as f:
>> > +                if f.read().strip() =3D=3D 'off':
>> > +                    break
>> > +        except OSError as e:
>> > +            print('failed to read kdamond state: %s' % e)
>> > +            exit(1)
>> > +
>> > +    print('PASS: damos_walk() vs kdamond exit race not triggered')
>> > +
>> > +if __name__ =3D=3D '__main__':
>> > +    main()
>> > --
>> > 2.34.1
>>
>> [1] https://docs.kernel.org/process/submitting-patches.html#commentary
>> [2] https://lore.kernel.org/20260524091812.35283-1-saileshnandanavanam@g=
mail.com
>>
>>
>> Thanks,
>> SJ
