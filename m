Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D118DDCD;
	Thu, 28 May 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978738; cv=none; b=mU32GLP3h+DqX6C86g1BQvd/aR81KVi94SUA4Y1f2FPUIOvkFGxtLDKZd5nq+OvWYT5IKVyLx4zzLv3Yfg7W/4+TVJFJIqxEpwDb+bSGVngg0O67uVAuagMPh2bfxKVigqnLi4/GEKXC1Wu3SBHeH/iuUgL1lDFEEdE1UX5rLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978738; c=relaxed/simple;
	bh=lebyUECeIXunKzxGshyjC38qWAjOLQA3rhzAtnmSPYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7pD9/Rlba8nTvlYgl0xZ8XJaE9/4HMUrGYR4FI+YdceEhOFKp2UksUKGO5IGR2aaNVDrvtAvdNQCj1o7wbOQKqvEA/82yC68oW0Mufi1ol3V8mS/a09RJqsx+sxQTcHZy021oN6bU33fAMrEcRVlfxwYcySzRMIZiA0l7lnphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUCKmi9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUCKmi9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FFA1F000E9;
	Thu, 28 May 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978737;
	bh=L6Hoh14jwpBsk0F4PvvCTKLeaoeOEHn1zN3j2kuRmgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iUCKmi9rswbLLaQKV1pfqUD1CcXPyXEPmZYpdrdV8+ZvVgg3/B522kSKrIYWGO/ZA
	 6OvDO/iGk185dYkGrH0V0/o5vPPArjiqayglj82BZ7DTGgODLYCFDqTUZx7k7xGedF
	 IpP3htgfk29MzCkFqcLgl+Lc/Ss+v5wziT58Rd4ZISqmRyvN0EbfXG2yor4nmipke/
	 /rpXuLdcZkDUaP780lwsCHF/Y1GKhZaQQbCTa6NjVoNCjouRgtprcOmq2/45/dTS1R
	 n8fqCxXdwm3q3aj21ioe+tIvYHpVeMa4YNerudehoAiO3G8lV9W8KhjM+QVjgBkxMA
	 GMYekX4H/wpuA==
From: SeongJae Park <sj@kernel.org>
To: niecheng <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH 0/2] selftests/damon: fix and validate memcg filter memcg_path handling
Date: Thu, 28 May 2026 07:32:03 -0700
Message-ID: <20260528143204.153713-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9479D47690DD7F07+20260528081039.1192194-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Somehow the mails of this series don't have correct 'in-reply-to' field, and
therefore not constructed as a single thread but three individual threads.
Please check your setup for next time.

On Thu, 28 May 2026 16:10:37 +0800 niecheng <niecheng1@uniontech.com> wrote:

> This series fixes memcg_path handling in DamosFilter and adds memcg
> filter validation to the DAMON sysfs selftest.
> 
> The first patch fixes DamosFilter so memcg_path is stored as a string
> for sysfs staging.  The second patch adds memcg filter validation by
> checking the memcg_path sysfs readback.

Nice catches and improvements, thank you!

I left a few comments on individual pattches, though.


Thanks,
SJ

[...]
