Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6526299;
	Mon,  1 Jun 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324771; cv=none; b=b9LMhxbIUGVuxelgi3R9GkdgRwaP7e0uSoWZdfvm5Iw//KW+SG/yoxiQ8vAA+OTHaSZqirGUpDjG4m3mFgt4GxxFpuhsTFbdqhdFt7dU7t1nBbkeig2srjV2LKlJXKLVZ96iJ69G1cWBH05AYeoj6XjFxFCeFd7WcGS63wWvFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324771; c=relaxed/simple;
	bh=J+g2NFblLICZNOaP0Ejw6L05aPXDFL/gUJwX5JGXb+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAGHw/B97G03ydDi5mujkubpHqjzw6qc/htlvcAUVX5wY2zHmSv5CLskxMsD4N/mXP5/HbMbJNcuU2XMZeZgi9h6gpzkDijny8ewhV2+jEZ8c2IG9z1FZpFP9Jnl7SxBi10F45biPTadVVKDVMVQS//lPvfSWUfrcZDrm7V9Vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1d0atvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1d0atvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9891F00893;
	Mon,  1 Jun 2026 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324769;
	bh=lbuVgLi6EARiwiI2lEn+0Hwi5JqyQq0Zb5p01BU0Q1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1d0atvzJb0Zb1KqKiOguLe+KCog42bZ+MpATbE2KhgFGVKMAV8fs6kKITf1LKGXJ
	 xb/up/pc1PIEcpI7CKiD843S3k/XkItQLyKPhFMQo6+oguHWxF3x6drjaE3xr4VYlH
	 w/5Si+rEPri7EUmAM8s7MTai8vABrNgeOI832mQcrd/zuv7A/d32TIOotJxCy+9R6d
	 VdGq9YMg1A0Pp9FUrb5a4S5sOByaszycF+A1147ReKRfroVvU8hKr+NlVm0tYkgbNw
	 tZMpHeMaAug0LXt1OPFUdxed1tlsbM+/tcJDGQk8/v7oiydV+YgJHM+FeeZb6opPva
	 b513vPCMgNehw==
From: SeongJae Park <sj@kernel.org>
To: Cheng Nie <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	shuah@kernel.org
Subject: Re: [PATCH v4 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 07:39:20 -0700
Message-ID: <20260601143921.115468-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <D2B37130D38E09AC+20260601090634.241864-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  1 Jun 2026 17:06:33 +0800 Cheng Nie <niecheng1@uniontech.com> wrote:

> Add a dedicated test at the end of main() that stages memcg_path via
> sysfs and verifies its readback.  Configure the memcg filter before
> start(), do not call commit(), and ignore start() failures so the test
> does not depend on CONFIG_MEMCG or cgroup layout.  Call stop() for
> cleanup without checking its return value.

Looks good to me, thank you!

> 
> Signed-off-by: Cheng Nie <niecheng1@uniontech.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
