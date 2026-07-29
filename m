Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8C38C2DE
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296708; cv=none; b=XOzy3YHHy7m3gV6LjByLwuHOqQrm9RYXL1kEBZg0Vnxk1tpfITDzfrbr586Z913rgeh8ikmebKvvkioVaFeDuqNnnH1bZVeCMidOLn+tRYHaISrsJbFHNlCwrz1AHe+bpvJQ6gMNvwcSOm2312O8YW+wEMPKHi6PUcUVSTo/m+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296708; c=relaxed/simple;
	bh=xLM1B0jpuROu1k6CiW29RJhVdqYmZTJZ6GUYijf3z/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sbsGZvn63eN50ewQcbdMFcBWeDSpMWlNWkMkV2QNyri0h0lAkjJTGeArKHsUL7RhtDD/6Qijzh9zCaIvbfkH+cVF6sdA8BAw2WDwAgAVKuEv5PtMTVUoK2VvkeqL1XtVXHGYWAoVGmh2boK9KITamwNtff1X0xgHT5dEF9+7t8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNOZZ1V5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNOZZ1V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E51F000E9;
	Wed, 29 Jul 2026 03:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296705;
	bh=Opa6q352I7rmNA7Rs+Oh8sX40Ha9DrFHjUlVR1lexSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XNOZZ1V5NdV5ZLZypNYLv6hunLIh4ZgTkc3Sjr//SUGD2NMlcX79fPTf8cFX3moMh
	 4wgohEePJZbu9aBQUyLBGX+jC0Tuq+3Whld4gMlS25pRYfaliqYKFMYZXriZKo3vzB
	 +k16qnxSqQRUAnL1vem5apkV0D8AUkChZQCkOgFSn8fBLSd2kHgK+y5/XVHC+5o0zO
	 75fHo+IWFJrK8SdnH2uMowc7Kaokg5QBBDeYxnWihP5Z9xh97TTbeviwGzeaeYqvvW
	 DX1f46RoN78pPzREcboLy83rW3/G7r99CZAsNILB/Lx9Q0KFahsr+g2045wXnW1i34
	 zrdUjC3bk6Ywg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 08/10] selftests/damon/sysfs.sh: test
 hugepage_mem_bp quota goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729033751.131213-9-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
 <20260729033751.131213-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:45:05 +0000
Message-Id: <20260729034505.933E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest script expects the kernel to accept the 'hugepage_m=
em_bp' metric for the DAMON sysfs quota goal, but the corresponding kernel =
feature implementation is missing from this patch series. Writing this valu=
e to the `target_metric` sysfs file will return `-EINVAL`, causing the test=
 to unconditionally fail and exit.
--

--- Patch [8]: [RFC PATCH v1.1 08/10] selftests/damon/sysfs.sh: test hugepa=
ge_mem_bp quota goal ---
commit 6c11ff9f30e87caf7ac58e12f507a641d985aebc
Author: SJ Park <sj@kernel.org>

selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal

This commit updates the DAMON sysfs selftest to verify that the quota goal
target_metric file accepts the new hugepage_mem_bp input.

> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selft=
ests/damon/sysfs.sh
> index f7fb94b84e716..8690aef1e436c 100755
> --- a/tools/testing/selftests/damon/sysfs.sh
> +++ b/tools/testing/selftests/damon/sysfs.sh
> @@ -210,6 +210,7 @@ test_goal()
>  	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
>  	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
>  	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
> +	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"

[Severity: Medium]
Will this test reliably fail because the kernel implementation for the
hugepage_mem_bp metric is missing from this patch series?

If the corresponding kernel feature isn't included, writing this value
to the target_metric sysfs file in test_goal() will return -EINVAL. This
would cause ensure_write_succ() to unconditionally fail and abort the
selftest.

>  	ensure_write_fail "$fpath" "foo" "invalid input"
>  	ensure_file "$goal_dir/nid" "exist" "600"
>  	ensure_file "$goal_dir/path" "exist" "600"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729033751.1312=
13-1-sj@kernel.org?part=3D8
