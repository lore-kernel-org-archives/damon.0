Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A5234964;
	Sun, 24 May 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779647882; cv=none; b=Lj0s2ho9v1DcI4KR7wSgAKIOn2tjWjCUnWv6o+6uIA4dDBn//vGnpfxR7B1NI9BNWKAKtIkOodoEiX3QN9Xorvec4f+H3DjXy3t+oHG44A3c6Csv6FS9VHbUg++c+eSTYD+mTfzjERYrXvLoUFbx/vTKibMIdu0QQO+MRg22mCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779647882; c=relaxed/simple;
	bh=58iTVX6WjFjjrk2CvKDdKmZX54iwwsjfGACPpkfXl8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/Ac87sCyyGPLpo8JKQvoZFL4iay3JtvEaAm14C4Qj6n2V0GSPM1jTlcgHPzpHt907+jdQ+Ov7wszwSgdmOw8temW32DnATKZkHbdDl233UrLdVdIWe9xPHL0Kl8OBXjm4OTq7boUcAQP4E8+aBrOiD+4Y7PY7GVH6BkzWxHa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwh7sFf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwh7sFf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79551F000E9;
	Sun, 24 May 2026 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779647881;
	bh=Q3Bi0Oe3WKFBfhaQU3r6X4HozuqIOgvqoIFf+5sZIZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uwh7sFf4RD5Yq38Xgy34+NfDbBdUlUYgSFlPJ11B2Rz5xuIqQaGvAwPRVnDs+H2NE
	 srqBwFFgv9tPUpKxGI69a0PHyEeamCc5UwkwmadPCqgwUXEKLyCRo0ZNLqGytQnozw
	 tvi2qJmkUZof6aPzT8167tjjF9+YbZlpqQTIKUSqxO27oTXXs62GDQV46w5/zcRMzi
	 Bb8+WFX9sIVHan4ir79sNR8EOEVKvBkL12bwHS0/nnIpUFTOEZjd7ntlGstFwOqV9b
	 SKW/9we1IBt9Z05BvzUI3g+RLBJa9Qo8tt7m0z628vlqjSFXC5idio2X472mRy/9kL
	 syrMrM6tmuacA==
From: SeongJae Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon: add regression test for damos_walk() vs kdamond exit race
Date: Sun, 24 May 2026 11:37:50 -0700
Message-ID: <20260524183750.1810-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524100258.36819-1-saileshnandanavanam@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sailesh,

On Sun, 24 May 2026 15:32:58 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> Add a regression test that verifies damos_walk() does not deadlock
> when racing with kdamond_fn() exit.
> 
> When kdamond_fn() finishes its main loop, it cancels remaining
> damos_walk() requests and unsets damon_ctx->kdamond. Without the fix
> in commit 33c3f6c2b48c, damos_walk() could be called right after

Please use more common commit description format that has the commit subject.
E.g., commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn()
exit race").

> cancellation but before kdamond pointer unset, causing it to wait
> forever for handling that never comes.
> 
> The test starts kdamond monitoring a short-lived process, waits for
> the process to exit naturally triggering kdamond termination, then
> rapidly calls update_schemes_tried_regions in a separate thread to
> hit the race window. Using a thread with join timeout ensures the
> test can detect kernel-level deadlocks where the system call blocks
> in uninterruptible state.
> 
> The sysfs state path is resolved dynamically via the kdamonds object
> instead of being hardcoded, and exceptions are handled specifically
> as OSError rather than using a bare except block.

Thank you for this patch.  But, is this test reliable?  I ran the test more
than 100 times on my system running a kernel that has commit 33c3f6c2b48c is
reverted.  But test always passed.

> 
> Fixes: 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race")

This is not fixing a bug in the commit, so the above 'Fixes:' tag is
inappropriate and may only confuse people.

> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> ---

From next time, please add changelog on the commentary area [1], with links to
the previous revisions.

I was able to find the previous version on the mailing list [2], so putting the
link here for others.

Also, before sending a new version, please share your revisioning plan and give
time (about a daay) for others to comment about.

>  tools/testing/selftests/damon/Makefile        |  1 +
>  .../sysfs_damos_walk_kdamond_exit_race.py     | 82 +++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py
> 
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
> index 2180c328a825..60c83d6c318e 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -20,6 +20,7 @@ TEST_PROGS += sysfs_update_removed_scheme_dir.sh
>  TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
>  TEST_PROGS += sysfs_memcg_path_leak.sh
>  TEST_PROGS += sysfs_no_op_commit_break.py
> +TEST_PROGS += sysfs_damos_walk_kdamond_exit_race.py
>  
>  EXTRA_CLEAN = __pycache__
>  
> diff --git a/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py
> new file mode 100755
> index 000000000000..8e8006d63926
> --- /dev/null
> +++ b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py
> @@ -0,0 +1,82 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Regression test for damos_walk() vs kdamond_fn() exit race.
> +#
> +# When kdamond_fn() finishes its main loop, it cancels remaining damos_walk()
> +# requests and unsets damon_ctx->kdamond. If damos_walk() is called right
> +# after cancellation but before kdamond pointer unset, it could wait forever
> +# for handling that never comes, causing a deadlock.
> +#
> +# This test verifies the fix by rapidly calling update_schemes_tried_regions
> +# while kdamond is naturally terminating (monitored process exits).
> +# Without the fix (commit 33c3f6c2b48c), this would hang indefinitely.
> +
> +import os
> +import subprocess
> +import threading
> +import time
> +import _damon_sysfs

Let's add a blank line before _damon_sysfs import, to be consistent with other
test files, like sysfs_update_schemes_tried_regions_hang.py.

> +
> +def call_update(kdamond, result):
> +    err = kdamond.update_schemes_tried_regions()
> +    result['err'] = err
> +    result['done'] = True
> +
> +def main():
> +    proc = subprocess.Popen(['sleep', '0.3'])
> +
> +    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
> +            contexts=[_damon_sysfs.DamonCtx(
> +                ops='vaddr',
> +                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
> +                schemes=[_damon_sysfs.Damos(
> +                    action='stat',
> +                    access_pattern=_damon_sysfs.DamosAccessPattern(
> +                        nr_accesses=[0, 200]))]
> +                )]
> +            )])
> +
> +    err = kdamonds.start()
> +    if err is not None:
> +        print('kdamond start failed: %s' % err)
> +        exit(1)
> +
> +    # Wait for monitored process to die naturally
> +    proc.wait()
> +
> +    # Rapidly call damos_walk() while kdamond is exiting
> +    # Use a thread with real timeout to detect kernel-level deadlock
> +    deadline = time.time() + 5
> +    while time.time() < deadline:
> +        result = {'done': False, 'err': None}
> +        t = threading.Thread(target=call_update,
> +                             args=(kdamonds.kdamonds[0], result))
> +        t.daemon = True
> +        t.start()
> +        t.join(timeout=5)

I'm not sure if this is reliable to trigger the exact race.  As I mentioned
abovely, I tried this test more than 100 times on a kernel that having the fix
reverted, but I was unable to make the test fail.  If it is that unreliable,
I'm not very sure if having this test is beneficial or just make people
confused.

If the test has no false positive, maybe having this make sense to
opportunistically finding the bug.  But I think the 5 seconds timeout is still
not very reliable on some case, and therefore it seems false positive test
failure is available.  If that is correct, I think having this test might only
confuse people.

I think having damos_walk() kunit test for its functionalities including the
walk_control_obsolete might make more sense.

> +
> +        if not result['done']:
> +            print('FAIL: update_schemes_tried_regions hung - '
> +                  'possible damos_walk/kdamond exit race deadlock')
> +            exit(1)
> +
> +        if result['err'] is not None:
> +            # kdamond stopped cleanly - expected
> +            break

Is the above if condition correct?  Could you please explain why having an
error here is expected?

> +
> +        # Check kdamond state via sysfs using dynamic path
> +        state_path = os.path.join(
> +                kdamonds.kdamonds[0].sysfs_dir(), 'state')
> +        try:
> +            with open(state_path) as f:
> +                if f.read().strip() == 'off':
> +                    break
> +        except OSError as e:
> +            print('failed to read kdamond state: %s' % e)
> +            exit(1)
> +
> +    print('PASS: damos_walk() vs kdamond exit race not triggered')
> +
> +if __name__ == '__main__':
> +    main()
> -- 
> 2.34.1

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://lore.kernel.org/20260524091812.35283-1-saileshnandanavanam@gmail.com


Thanks,
SJ
