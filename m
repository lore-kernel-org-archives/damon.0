Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485F36E494
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244418; cv=none; b=lcVkhmPHORTIanf7YJ5akXgsnnYQIhP5USzrXnDAFXj0jggSdT2FQ7C9UpDoMseEJmrHFUS0Kvmx6zndnkeOqKcYtPrf7MMPTc/+yL0XJEom/EvsDY1Dts47Vz9wKsZ9dFw4Nn19JjZ5c8LY+63igwp7KrDnE4qWjTlvM5l+0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244418; c=relaxed/simple;
	bh=wsaUdnF6vdNCvH3wKf9qH5sgIjo15LducaMlKRqpI3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYeYB8BjE0ZgGkBrWDWnERDv973dSL7zW7ahD+IivqBm6QAwnOXSB6Z2tU+G0oM99zqs4GLfRavJqciOXUEmPNf+VzFWgjGlwEKx2w65Chub6Rs4jnYuzHQ3ZvvU88yvMeVm5s/VOmmC3Tutl3W9iy4KzAeDsJjSoofOA5H8bMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jog77OB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jog77OB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C491F000FF;
	Sat, 12 Sep 2026 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244416;
	bh=HytthUWkD3BKz8RWo0pM9ayfyBnS0cp7iIRv1xmw5iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jog77OB4m/sbpl9E5uN0bN3YJk/tGuNo3UnvSiU71nIurti4l5Y2zJ97TvV0rCe6g
	 zaNgGoHi+ZiqCfz9kcRkYS0DFpNLb0hk3nZh1smaBI5Mpd8ipocOoWnTddE1z12iGb
	 FnntdvU36pGBRqE0P1avZvukY//ksDwN+0kIeW6xww3GupyMRWqCmPbK50c+QbDqTg
	 fWc6uTO2Lb98UgLvQrP2QuGAhAWi9XGPC1zhmPwagdKKM6yZUmsam9gcw1Dz8ll8Ju
	 E6uFsmnnotswdthToU/u1XK7SeE38fmOFI3aSQMAnfYBP/Nr+Z+4RSL5wA/BskXheK
	 DAMln9MfiG+Cw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 7/9] selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
Date: Sat, 12 Sep 2026 13:20:08 -0700
Message-ID: <20260912202009.146576-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912201518.700171F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 20:15:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Use of the non-standard `--quiet` flag in `grep` can cause the test to silently mask real memory leaks on systems with strict POSIX grep implementations.
> - [Low] Typo in the warning message: 'apparenty' instead of 'apparently'.
> --
> 
> commit afc83fe4758b4c2e76cc3da97cb99e2a990b6b83
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
> 
> The selftest can fail for any leak if it happens while the test is running.
> Remove the false positive test failures by further checking if the expected
> leaking function is called out on the report.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> > index 33a7ff43ed6cc..6c2d8bb3fe570 100755
> > --- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> > +++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> > @@ -41,5 +41,12 @@ if [ "$kmemleak_report" = "" ]
> >  then
> >  	exit 0
> >  fi
> > +if ! echo "$kmemleak_report" | grep "memcg_path_store" --quiet
> 
> [Severity: Medium]
> Could the --quiet flag cause the test to accidentally mask real memory leaks?
> 
> If the test runs in an environment with a strict POSIX grep implementation
> that does not support the GNU extension --quiet, grep will fail with an
> unrecognized option error.
> 
> Because of the negated condition, a non-zero exit code from grep causes the
> script to evaluate to true, print a warning, and exit 0. Should the standard
> POSIX -q flag be used instead to ensure compatibility?

I believe kselftest runs on systems modern enough to have --quiet option.  Let
me know if I'm wrong.

> 
> > +then
> > +	echo "[WARN] memleak found; apparenty not from DAMON, though"
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in the warning message (apparenty
> instead of apparently).

Good eyes, I will fix in the next spin.

> 
> > +	echo "$kmemleak_report"
> > +	exit 0
> > +fi
> > +
> >  echo "$kmemleak_report"
> >  exit 1
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912200814.145612-1-sj@kernel.org?part=7


Thanks,
SJ
