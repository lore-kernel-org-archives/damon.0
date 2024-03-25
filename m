Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179B6EB5A;
	Mon, 25 Mar 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389492; cv=none; b=fWHGpMYijGlX2E5JKUgdjbY0lGzyUZH75JjykTziCjAutIVB0QFhxYjWr/MXjVuJjoFFV7T76j6btjFtPRmHwcA/OjHYAoXj2L7wVhEUqnnPHUvcy+Jzog6xMUh5Z/T1HPGuiWTxnQZWr4XOADobdIEYkxZtjNQFPuzIG+4zSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389492; c=relaxed/simple;
	bh=9E7xV6pO5OM8ZlXuYmIsQSFhdgboHZuhsgsRWEeTPRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6YIPMFCixUTX/uMJjOGRD0qFZaaKeLKZpPcFX5ZTR7CG1rlKvE1yy508HhWHr5YAm8kYVaZLFUgkjnk+BCEybK++cK5Dp1CeWI4ASnEibxenNe5jzvGBq1z33exKE0fPHc8QwRKfIBktpFTBBZghL8AHerIWJu5jXyEgL62ZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNjcqAoc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNjcqAoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D82C433C7;
	Mon, 25 Mar 2024 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389491;
	bh=9E7xV6pO5OM8ZlXuYmIsQSFhdgboHZuhsgsRWEeTPRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNjcqAocxqzTgKPpl1stb394Zn+1gq5wWWPKPayPgK89Ctfbl1gGEfirFlwsBMeGB
	 s1NBUashYoAmLtFGTIklPCzDwjPDb1iafP9XZxC+kT9IFWwL05tBeKWpyF6rnBLZer
	 ryX1WpLtnJ0INI7nOBt84mJeOuxDFyRLA/XPXAQJahVlXmTT9coqzdBpLL5+r8YtD5
	 2HAQPS4bg6hk/y2/piiCZP4XxFJaMoKVUocBFAVQkxSqCMhR1XkRq7dP69/VkZpOhR
	 Ebm2Yud2SLMN7WXPt4ipXsm/X0+hZigjGbTnU36EQqftCY0OrxRltGBqxJSujb43Eu
	 U2YGj6cmHHTbw==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com,
	pavel@denx.de,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
Date: Mon, 25 Mar 2024 10:58:09 -0700
Message-Id: <20240325175809.233591-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 25 Mar 2024 07:59:51 -0400 Sasha Levin <sashal@kernel.org> wrote:

> 
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.

This rc kernel passes DAMON functionality test[1] on my test machine.
Attaching the test results summary below.  Please note that I retrieved the
kernel from linux-stable-rc tree[2].

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/awslabs/damon-tests/tree/next/corr
[2] e9d47628c833 ("Linux 6.6.23-rc2")

Thanks,
SJ

[...]

---

ok 1 selftests: damon: debugfs_attrs.sh
ok 2 selftests: damon: debugfs_schemes.sh
ok 3 selftests: damon: debugfs_target_ids.sh
ok 4 selftests: damon: debugfs_empty_targets.sh
ok 5 selftests: damon: debugfs_huge_count_read_write.sh
ok 6 selftests: damon: debugfs_duplicate_context_creation.sh
ok 7 selftests: damon: debugfs_rm_non_contexts.sh
ok 8 selftests: damon: sysfs.sh
ok 9 selftests: damon: sysfs_update_removed_scheme_dir.sh
ok 10 selftests: damon: reclaim.sh
ok 11 selftests: damon: lru_sort.sh
ok 1 selftests: damon-tests: kunit.sh
ok 2 selftests: damon-tests: huge_count_read_write.sh
ok 3 selftests: damon-tests: buffer_overflow.sh
ok 4 selftests: damon-tests: rm_contexts.sh
ok 5 selftests: damon-tests: record_null_deref.sh
ok 6 selftests: damon-tests: dbgfs_target_ids_read_before_terminate_race.sh
ok 7 selftests: damon-tests: dbgfs_target_ids_pid_leak.sh
ok 8 selftests: damon-tests: damo_tests.sh
ok 9 selftests: damon-tests: masim-record.sh
ok 10 selftests: damon-tests: build_i386.sh
ok 11 selftests: damon-tests: build_arm64.sh
ok 12 selftests: damon-tests: build_m68k.sh
ok 13 selftests: damon-tests: build_i386_idle_flag.sh
ok 14 selftests: damon-tests: build_i386_highpte.sh
ok 15 selftests: damon-tests: build_nomemcg.sh
 [33m
 [92mPASS [39m
