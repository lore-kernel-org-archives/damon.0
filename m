Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5421379C31;
	Mon, 29 Jun 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744496; cv=none; b=abd2M8ojkKu6O4nfoMtESRkF1I3dqNNasxJwWjIaHWgyrJYOzsC8P/8eT+HEPff8EJLJK72cQ848oZ0zTno/18uupO8ermSNaZCPLawEadarUwQiSyOH9Cf2mSta1iq0B+DPXPcO7teUH/HNorUz+adXjVvr+8AMiRen76ENR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744496; c=relaxed/simple;
	bh=Kwzuz6DuwKd065Jne4Y4me5e+oxTq2PrVrL/2lKz8D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeuiJdofwNAbe+O3QniJWNFh+td/p8hvDFZA6W+KNLzxCuGiiKUdx/mqrlJq3UmIreyNulHqsYwtk9GynSXUy78frJbsDQhzsL30zka8KUQWcCGDrzZSEGb99q/G7SiNZCrvXukNfXYd43epex2EIbBEo5axVau2xHgg4cdmQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hATrsdHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hATrsdHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852CA1F000E9;
	Mon, 29 Jun 2026 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744495;
	bh=Br7Ex/IiLw8lCRB440Qh40MypLwSStBTcOqHVSbRwdk=;
	h=From:To:Cc:Subject:Date;
	b=hATrsdHOFRVmCCWsmVipAjo7dTzB7xOskMSbaNA1pV4gFlPkzzQ+RL0PBNpDyDAf6
	 qtnQpjab16uu6WJbM6c12dEYTJT9HuAVJBUZgRb3ic+zmcfje5umMDi8rWWo+ZFL3j
	 OdR145B3UwbmaFb7XDvGQPyX+edjygKOto/BGxHVv8hi+w+Isoxk0j0kynfvjBYk92
	 Tu79AL9MZnfgwP4aHgYnPguY92YRoUnIBxgpZtPMp6R52YFzMq0yfnHl82wdZsrjOo
	 UXTAq6LmsAQt5EL+AqXxK6j3nzJUdR+/MusdkFaG9isvpXl1LRN/lf3jd1sWUycOll
	 x5iTyC+gKNhhw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 0/2] selftests/damon: fix memcg_path staging handling
Date: Mon, 29 Jun 2026 07:48:09 -0700
Message-ID: <20260629144812.134159-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug in _damon_sysfs.py for damos_filter memcg_path setup, and add
a test case of it in sysfs.py.

Changes from v4:
- v4: https://lore.kernel.org/7E6EAB7C1BE04DEA+20260601090119.238457-1-niecheng1@uniontech.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.
Changes from v3:
- v3: https://lore.kernel.org/E4B88E7D4879D1B1+20260601074250.203583-1-niecheng1@uniontech.com
- call stop() for cleanup without checking its return value
Changes from v2:
- v2: https://lore.kernel.org/4CDA28DC581FDCF8+20260529090845.1696845-1-niecheng1@uniontech.com
- configure memcg filter before start(), remove commit(), ignore
  start() failure, verify memcg_path staging readback only
- use print-style error messages as suggested
Changes from v1:
- v1: https://lore.kernel.org/406BD1BA0F6AE326+20260528081039.1192194-3-niecheng1@uniontech.com
- unknown.

Cheng Nie (2):
  selftests/damon/_damon_sysfs.py: fix memcg_path assignment
  selftests/damon/sysfs.py: validate memcg_path staging readback

 tools/testing/selftests/damon/_damon_sysfs.py |  2 +-
 tools/testing/selftests/damon/sysfs.py        | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)


base-commit: 544856bcdccf456fc27f85e5d5b0a49f7b8e6019
-- 
2.47.3
