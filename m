Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F772E370A
	for <damon@lists.linux.dev>; Fri,  8 Aug 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690730; cv=none; b=ldIL/mW6Tugr8ezjo1YOOfOHobYi99ak3diB0dfCnzXKZwHaLgjZSHdfd/7uC233eCDtPKNkdbdWnhK4Ntr4XTKyKBlG1TvxocaBiF6CWgPx5U7NyUbvyueq4n6kRktojG9K4eFjokYyO+rsb2AUnua2jMReKNTU6jynXbcByQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690730; c=relaxed/simple;
	bh=pfGP4YkhAWdDQXnzRb1X7+xSMsz+/BM3ycyTOCBEH4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBmGutSwbxKlUUZrqEkunKD3y57Ihop6S/YHsNJ/J0cIWiD8gmclXuaZy8FxNezj7dT0pWOMJB3WoDD0JB0+tJuymxKPGjV9wdyid8kh4Y+zw57cRzVR43eSFym8p26jqtNVGgcW0SP1geFEg3/136bwFNXty/Mq8VBx4JNaJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGcZUE1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGcZUE1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742AFC4CEED;
	Fri,  8 Aug 2025 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754690729;
	bh=pfGP4YkhAWdDQXnzRb1X7+xSMsz+/BM3ycyTOCBEH4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGcZUE1nNXn4BoM/oCYk/+0Bz2/6DINZSYVTNOQOTFZhbHe6KYaYn/Q3pDv+siVbA
	 mq1oW27vdPPEaUhAp3JGEzqYEpDq35bkYKyBq06V9PTdIh2p0Y3+QGRiDx9LTkr9Zb
	 /zgIbv1H5g+fVM2a77BlvwflfNNSPV16SlGLZ6oRPT0SaJG3dFVi9cQmeZtuQMwiWV
	 KAXoRx2yp+joRKfqCIAKu6ctb7RUZB8ma/bM6OYPgOFHxTigs35+mgdgqpbh4yU5Ek
	 hjybFPukDZ0fuua4v201yCkgzO7PPuINYj6iyntVPr/GZ/AbQ8RRVkXWhu9iYW8DZF
	 dcuUPAC05IFHQ==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] selftests/damon: test no-op commit broke DAMON status
Date: Fri,  8 Aug 2025 15:05:26 -0700
Message-Id: <20250808220526.49546-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250808195518.563053-2-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sang-Heon,

On Sat,  9 Aug 2025 04:55:17 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Add test to verify that DAMON status is not changed after a no-op
> commit.

Thank you for this patch!  I have some comments below, though.

> Currently, it is failing. but after fix the bug it should be
> success.

To keep bisecting goes smoothly, let's introduce failing tests _after_ their
fixes are landed.

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  tools/testing/selftests/damon/Makefile        |  1 +
>  .../damon/sysfs_no_op_commit_break.py         | 78 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> 
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
> index 5b230deb19e8..44a4a819df55 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS += reclaim.sh lru_sort.sh
>  TEST_PROGS += sysfs_update_removed_scheme_dir.sh
>  TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
>  TEST_PROGS += sysfs_memcg_path_leak.sh
> +TEST_PROGS += sysfs_no_op_commit_break.py
>  
>  EXTRA_CLEAN = __pycache__
>  
> diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> new file mode 100755
> index 000000000000..300cdbaa7eda
> --- /dev/null
> +++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> @@ -0,0 +1,78 @@
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
> +        subprocess.check_output(['which', 'drgn'], stderr=subprocess.DEVNULL)
> +    except:
> +        return None, 'drgn not found'
> +    file_dir = os.path.dirname(os.path.abspath(__file__))
> +    dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
> +    rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
> +        stderr=subprocess.DEVNULL)
> +
> +    if rc != 0:
> +        return None, f'drgn fail : return code({rc})'

Let's not add a space before ':', for the consistency.

> +    try:
> +        with open('damon_dump_output', 'r') as f:
> +            return json.load(f), None
> +    except Exception as e:
> +        return None, 'json.load fail (%s)' % e
> +
> +def main():
> +    # We can extend this test to change only the Given and reuse the When/Then.

Above comment seems unnecessary to me, since that's obvious.

> +
> +    # Given : setup filter with allow = True

Again, I don't think the above comment is necessary.  And this looks like a
pseudo code more than a formal comment.  If you think it is necessary, please
use more formal tone.

Also let's not add a space before ':', for consistency.

> +    proc = subprocess.Popen(['sleep', '10'])
> +    kdamonds = _damon_sysfs.Kdamonds(
> +        [_damon_sysfs.Kdamond(
> +            contexts=[_damon_sysfs.DamonCtx(
> +                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],

Can't we start this kdamond with paddr ops, and drop the 'sleep' process
invocation?

> +                schemes=[_damon_sysfs.Damos(
> +                    ops_filters=[
> +                        _damon_sysfs.DamosFilter(type_='anon', matching=True, allow=True)

Let's keep 80 columns limit[1].

> +                    ]
> +                )],
> +            )])]
> +    )
> +
> +    err = kdamonds.start()
> +    if err is not None:
> +        print('kdamond start failed: %s' % err)
> +        exit(1)
> +
> +    before_commit_status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> +    if err is not None:
> +        print(err)
> +        exit(1)
> +
> +    # When : No-op commit, it should not break anything

Again, I don't think the above comment is necessary.  And this looks like a
pseudo code more than a formal comment.  If you think it is necessary, please
use more formal tone.

Also let's not add a space before ':', for consistency.

> +    kdamonds.kdamonds[0].commit()
> +
> +    # Then : Check value with drgn

Again, I don't think the above comment is necessary.  And this looks like a
pseudo code more than a formal comment.  If you think it is necessary, please
use more formal tone.

Also let's not add a space before ':', for consistency.

> +    after_commit_status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> +    if err is not None:
> +        print(err)
> +        exit(1)
> +
> +    before_commit_dump = json.dumps(before_commit_status, sort_keys=True, indent=2)
> +    after_commit_dump = json.dumps(after_commit_status, sort_keys=True, indent=2)

Let's keep 80 columns limit[1].

> +    if before_commit_dump != after_commit_dump:

Can't we jsut compare before_commit_status and after_commit_status?

> +        print("[TEST FAILED] : no-op commit break damon status")

Let's not add a space before ':', for consistency.  In this case, I think ':'
is not necessary at all.  Actually, since this test is for the single test
case, and kselftest framework will say this failed, I think the above print()
is not necessary at all?

> +        print("===== before_commit =====")
> +        print(before_commit_dump)
> +        print("===== after_commit =====")
> +        print(after_commit_dump)
> +        exit(1)
> +
> +    kdamonds.stop()
> +
> +if __name__ == '__main__':
> +    main()
> -- 
> 2.43.0

[1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings


Thanks,
SJ
