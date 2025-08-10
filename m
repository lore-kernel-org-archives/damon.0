Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFB246BD2
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830739; cv=none; b=hrYEcBj+QieuJD+GP/UFAriiQ1YhlANRk+k+J9PfQng/pUj47oxIKq7fC4PBDloqum2wiat/twMmOUxv3oKH31lBRYVwkR5VZwMhnkZhL8MBZoH/JvRpGJdy4G7DZpECRdqZQtqJekldQRtwdpXNdplTIgkkcjT8dF7FfuX+cQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830739; c=relaxed/simple;
	bh=ZvZFHoPneN2dc/ZNFIaHZ1MhSzM7T5k8pWQimps78kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G84XcV3CTC5Ui4G5BDn+Lh3WYzggKcLfeUy8vQZywpGceW50vXSRylRsxsgRDD5ZwKSOfXn7hhAtjteiIXwSJnrHjNszdWghLXUEnkB+z/MYSwuFSUWpiS1cSd4Xc0LRFvRoWradQ+5oTjQYqGJtjoK6WgISNenatCXAz3mBr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H//wKONj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H//wKONj"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-306db05b292so1205696fac.1
        for <damon@lists.linux.dev>; Sun, 10 Aug 2025 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830734; x=1755435534; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuqcSADnXqnWDt2KXmVA1zBALEN31klBjKcBY7VnF4M=;
        b=H//wKONjqLOq2ipounOjcS8orV1kIhIO0XIK2WpzhA/ZTrv1+Umu0fDiqcJSgChPAt
         rfsYyck9Qa93kMT6gRhkFZKwZLlsgVXvrG3dzzsPBNBkfElltI2Z5apkWq65ZHlk4Jt2
         LEUowM+lDaNkSbTdySzRCiAIXgJ/8x76jxP+u8ajBfdvLwYz/vygJ8Q5TXhHVSgoRsIE
         Fy2Dskz2lvmdKs7RqZtixs4j9qAk+A5ySDfQvc15TYGWOnQ/1KSgGo76snBl408Iq1Ce
         LMeUT5nc4Ny9VlSH5lHspjrwETqLDOqCvTGt5/OSiw/4Xdq8dj6mIUB08sJFRAOwQ1V5
         R3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830734; x=1755435534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuqcSADnXqnWDt2KXmVA1zBALEN31klBjKcBY7VnF4M=;
        b=uyX1Hh6oIWbMgMkSE93a60NzQIxVoszQZVgcUgkl+BxeQPEK8LpDmQtWneqWo2c1kY
         R1OekS2Bxp+qdgUFgoG6932wHv9JpteoqXb21yl/wKiuUgE+pmVqIaCiY+Fokd/e8szZ
         2CN4CmLTjshpOuhAIwkuPmT3F+uAjSpSz4AVTAX03wBe4+bQ7WBNKX0x1k4F4Svv59b6
         mS+9MMbx5igxg1APS2mTYfMufNhTs9YxZnHdUHFmm2bJcjd+LEIseHAr4C0JJs2Ee2rH
         O1+YaRIkZvPm3zxVtAyStkpttUnPhZjB+re+xouS5jj4vOhKyRZ/u7MgmRGuFG0JrvO6
         hSwA==
X-Gm-Message-State: AOJu0YzCFXKIO/Ep/vzu8cwu3W8DKv9/YVcvYpJNBMxjVW8PLylZcEjo
	LZ3wT/vISVdbyGR6MW491uGi38u4iwySwRXn1aoZgAFrJGNPkNifTinS0ETD2kVoXN+xSokCzp9
	s8gonFaS8HOQsRwz6p7t+oECsRLLh5v7l85VoVAg=
X-Gm-Gg: ASbGncvdnZw/3Ku0tv3PtZTvRJKfsJastkTwbP0otOKDyNA46kSI+1ef6d6q/C2Tt+r
	GgBHUkXHO8JIOhFZHpYy3bhQJKGc8pBr63bFFcQOFU380MyTtLlDxnAlEgy7bQEBKO+X7xHM10j
	XiUHW2h5XZcgAD8vXP63OomKOGYANESJaaX3crzJYrmiIMKQvdc7F6Uv3Clss4ZBWkM6e9OEBPG
	j7M
X-Google-Smtp-Source: AGHT+IGWxdU8yg429wV/BEb3fwg5pdBborKVwW4JfYTj0EisAf/O7g6UCqz7QBFgg2+6oztJ/ZtPGCd/hmS6rk//c8U=
X-Received: by 2002:a05:6870:d60a:b0:2d6:2a40:fbe7 with SMTP id
 586e51a60fabf-30c20ea1839mr6002024fac.6.1754830734392; Sun, 10 Aug 2025
 05:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250810124354.16456-1-ekffu200098@gmail.com>
In-Reply-To: <20250810124354.16456-1-ekffu200098@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 10 Aug 2025 21:58:43 +0900
X-Gm-Features: Ac12FXyAVojbHXaYNEc1bAVyQmTG6kEonLtZC-nGoddoNe4AthOe6g-HBOLDrJ0
Message-ID: <CABFDxMGHz_DJJncoE=ZUkBJwyph=_3WTfgd7H-0XyAdtuKtWJg@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/damon: test no-op commit broke DAMON status
To: sj@kernel.org, honggyu.kim@sk.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 9:44=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> Add test to verify that DAMON status is not changed after a no-op
> commit.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

I just forgot to add change logs.

Changes from v1 [1]:
1. Fix code and commit message style.
2. Merge patch set into one patch.
3. Add fixes and cc section for backporting.

Changes from v2 [2]:
1. Separate the patch into two parts(code modifications and tests) And
this is part of test
2. Improve warning message on dump failure.

[1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@gmail=
.com/
[2] https://lore.kernel.org/damon/20250809130756.637304-1-ekffu200098@gmail=
.com/

>  tools/testing/selftests/damon/Makefile        |  1 +
>  .../damon/sysfs_no_op_commit_break.py         | 72 +++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_brea=
k.py
>
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selft=
ests/damon/Makefile
> index 5b230deb19e8..44a4a819df55 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS +=3D reclaim.sh lru_sort.sh
>  TEST_PROGS +=3D sysfs_update_removed_scheme_dir.sh
>  TEST_PROGS +=3D sysfs_update_schemes_tried_regions_hang.py
>  TEST_PROGS +=3D sysfs_memcg_path_leak.sh
> +TEST_PROGS +=3D sysfs_no_op_commit_break.py
>
>  EXTRA_CLEAN =3D __pycache__
>
> diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/=
tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> new file mode 100755
> index 000000000000..f557587ebc81
> --- /dev/null
> +++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> @@ -0,0 +1,72 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json
> +import os
> +import subprocess
> +import sys
> +
> +import _damon_sysfs
> +
> +def dump_damon_status_dict(pid):
> +    try:
> +        subprocess.check_output(['which', 'drgn'], stderr=3Dsubprocess.D=
EVNULL)
> +    except:
> +        return None, 'drgn not found'
> +    file_dir =3D os.path.dirname(os.path.abspath(__file__))
> +    dump_script =3D os.path.join(file_dir, 'drgn_dump_damon_status.py')
> +    rc =3D subprocess.call(['drgn', dump_script, pid, 'damon_dump_output=
'],
> +        stderr=3Dsubprocess.DEVNULL)
> +
> +    if rc !=3D 0:
> +        return None, f'drgn fail: return code({rc})'
> +    try:
> +        with open('damon_dump_output', 'r') as f:
> +            return json.load(f), None
> +    except Exception as e:
> +        return None, 'json.load fail (%s)' % e
> +
> +def main():
> +    kdamonds =3D _damon_sysfs.Kdamonds(
> +        [_damon_sysfs.Kdamond(
> +            contexts=3D[_damon_sysfs.DamonCtx(
> +                schemes=3D[_damon_sysfs.Damos(
> +                    ops_filters=3D[
> +                        _damon_sysfs.DamosFilter(
> +                            type_=3D'anon',
> +                            matching=3DTrue,
> +                            allow=3DTrue,
> +                        )
> +                    ]
> +                )],
> +            )])]
> +    )
> +
> +    err =3D kdamonds.start()
> +    if err is not None:
> +        print('kdamond start failed: %s' % err)
> +        exit(1)
> +
> +    before_commit_status, err =3D \
> +        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> +    if err is not None:
> +        print('before-commit status dump failed: %s' % err)
> +        exit(1)
> +
> +    kdamonds.kdamonds[0].commit()
> +
> +    after_commit_status, err =3D \
> +        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> +    if err is not None:
> +        print('after-commit status dump failed: %s' % err)
> +        exit(1)
> +
> +    if before_commit_status !=3D after_commit_status:
> +        print(f'before: {json.dump(before_commit_status, indent=3D2)}')
> +        print(f'after: {json.dump(after_commit_status, indent=3D2)}')
> +        exit(1)
> +
> +    kdamonds.stop()
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> --
> 2.43.0
>
