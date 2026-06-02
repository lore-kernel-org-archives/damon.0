Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535703B6348;
	Tue,  2 Jun 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410215; cv=none; b=eQoggGTbm5pz4AYQYO4K0ZRLH/C1k+2tBHdleAxvnPaDHHc6t3bC6mZP9tEsO3qJlonr3Es9AP/bUkAe/GzPAlegkkWjYM7mQhTGnIyO/gzuoVEjbAZurV/cViQYupuQ0vdOazaUCcsrwI1/ttNybspKaQvJpxmBsIwNk3ELftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410215; c=relaxed/simple;
	bh=++d0toruRA5+nMB/G8ikhZDxcLJCTHt4txsSwu99dzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc9DIhZPPS2t4AksaSbs+aWgvqfy9Z5dIBs7pJzd2eDVZe4MAbC/48SmaoqcntVRPI3cWbqSMERWfj3U3LOesGsH8WzhArrBQeKGdaBm9quMQCFdom6PTG9mwvrsbJUOuxMsD7FjBMn4HRtb8dcWx8Xo3EQc6nkXMYLzNcfb67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpA95589; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpA95589"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45EE1F00893;
	Tue,  2 Jun 2026 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410214;
	bh=eGMvFUKf+E59w4JOYmw7LcNq+OCPKabJzFFOMVmOnEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SpA95589+ipumw5VHySo2fV4s8ZGh2wyUm2FULSPRJFNwz4u0hcrvDEH4WGqDogAu
	 ZSmUAgpUAjM/OMMURAfRGz7VDedxD5mlpJkOYxXcmSc1zGo+NMrh2xjYzIJ7zSZ0Vj
	 yeSA2pJ6xSmNU+CtzNPxETytqaQhVGZIcdmCq/OmYNF2FbdOBF3Cm6YBfxtbhcf02R
	 pZ8E7TlCb0PwBAyyjV+e7jSyONZp6Nb6tpSv/9x5OVeywzfEKHbxNGsH1AwyWGTCEn
	 WP9iyHsBZoruVX5HTd0O9Yk7ULJKa/tkgVVzB9rOKKL7V9qJ/EGTRwakhcDg+bSmbK
	 DAPRADr+8ZKmw==
From: SeongJae Park <sj@kernel.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/damon/sysfs_refresh: test kdamond refresh_ms
Date: Tue,  2 Jun 2026 07:23:23 -0700
Message-ID: <20260602142324.102073-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602131217.2210912-3-linuxoid@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Jun 2026 15:12:17 +0200 Ruslan Valiyev <linuxoid@gmail.com> wrote:

> Writing a non-zero value to a kdamond's 'refresh_ms' sysfs file should
> make DAMON periodically update the read-only sysfs files on its own,
> without the user writing update keywords such as 'update_schemes_stats'
> to the 'state' file.  This behavior has no test coverage.
> 
> Add a test that starts a kdamond with refresh_ms set and a 'stat' scheme
> whose default access pattern matches every monitored region, then polls
> the scheme's 'nr_tried' stats file directly, without requesting an
> update.  The value can become non-zero only via the periodic refresh, so
> the test confirms refresh_ms works; with refresh_ms disabled the stat
> stays zero and the test fails.

Thank you for adding this nice test!

> 
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
