Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891254939B
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655516; cv=none; b=QZ4c+YevrrhuEWAnL+P6yDyu4JzpBOMePflYuE34co4rnjGse4WHl2VY99lrnFaq2mSHsm5JumX2FbmFKB/ziyefApxvi5RCpOGcLIIK1bmwcdlKf3e3flnLrg42Wn74lTw8TvowFoz4FVHB5CC6R57t3KpQGZbA7xNg6KKtk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655516; c=relaxed/simple;
	bh=BCqYUstMB4EEnZSAW9NF9mOGgrYz0wPQ4UVbeLC3jZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jKcJn1y6nZtdACS49pkzQ6zQQHOWSnirJwnDvNrPkS8bQvAU5rlfg2k5QqKyjT/UiI9qGJ+AdMLJR4wkUpIy9LBtOb9S0+6oUGJ3UIMdf9gArFsGycDfP61D3vErcBdvJ5FstI+/vGV+YR6WxGC4fQTi/or4UuOENoMEK42TEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS8M2YbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS8M2YbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7301F000FF;
	Thu, 17 Sep 2026 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655515;
	bh=NdapkWw0mE1Bj+YdsjhJqtYJfco0G4T/e1jBxtOL9vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IS8M2YbT2rsf1iNlrA/dKt6BU6iyK/8mvFwKQJ97l9IfC4tunpuIqY64ZaH+8jGwm
	 CBGZKSKyfTnmStTEmP9Bfn5yeedMMMp/krbCyzUQaE/e10NbJwvWNU1qYWAK/gciqP
	 l0Y3BX27PMNWxh8MEVQPQVjYEv7LITpeT7Ik53j8d/5XM28O1Dc1R5RnQEYo+MGU9a
	 6YmATLALOHFRNiT92N7zRvRvmglo2jzaCkR3HYHSdIP8ZAGqTxcFq+Gc+4AQSYDZIp
	 /cgpi+DPxHo1VuJiWpX1Blj1IWRqGRBOD/30VHnIA+l5gjS0R1qJws0jAmf2LhOYo9
	 Sa0CuwPVKZI3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] selftests/damon/sysfs_memcg_path_leak: fail only
 for real DAMON leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-10-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:31:54 +0000
Message-Id: <20260917143154.DC7301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/damon: test falsely passes on minimal grep due to --qu=
iet flag
--

commit 3a025795f6efb7b8edc7858f005049159a83efbe
Author: SJ Park <sj@kernel.org>

selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak

This commit updates the DAMON sysfs_memcg_path_leak selftest to explicitly
check the kmemleak report for "memcg_path_store". It exits with success if =
the
leak doesn't appear to be related to DAMON, reducing false positive failure=
s.

> diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/too=
ls/testing/selftests/damon/sysfs_memcg_path_leak.sh
> --- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> +++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> @@ -41,5 +41,12 @@ if [ "$kmemleak_report" =3D "" ]
>  then
>  	exit 0
>  fi
> +if ! echo "$kmemleak_report" | grep "memcg_path_store" --quiet

[Severity: Medium]
Will this script falsely pass in environments with a minimal grep
implementation?

If this selftest is executed in an environment (like some BusyBox builds or
Alpine Linux) where grep does not support the GNU --quiet extension, grep
will exit with an error code.=20

The ! operator will negate this non-zero exit code, causing the condition
to evaluate to true. The script will then enter the then block and exit
successfully (exit 0), potentially masking real kernel memory leaks.

Could this use -q instead of --quiet to be more portable?

> +then
> +	echo "[WARN] memleak found; apparently not from DAMON, though"
> +	echo "$kmemleak_report"
> +	exit 0
> +fi
> +
>  echo "$kmemleak_report"
>  exit 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D9
