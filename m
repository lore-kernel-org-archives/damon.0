Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154869;
	b=qzFAlgk8K12sPiP63I+lEAkr/hq121gUr3UqIIXrHP5lckTj1NoVQ2mV2nCwAK/uuAvo
	 yO+QDsU8I3sRygHEtehu8cRFawPiXz5em4lU+cmz/pmwre9U0LJ3n6sPCg/+CyH+ZwhEm
	 EwU4b/8DsJq8WRzJ8+O1IfA/DC+KqLTbXI6MqaYaGsYSt+XpSKDfuhl19lFVFRFkXxUYt
	 dy1evebtQkKp4Sk9skQ2UK/G0nsH8PpaZDc9xcRdmctIAWmniRyvLbVNWQWCY7RJRri9E
	 J44QUJi8VGAriaRGNh/GTl6KWpDuJgFHyaVMWXs7DjnhvUqzqyEMhqai5NxaUjASLag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Q/Sp05AiIZSb9V9uY0yDUF0lL9up7p30RJjOrcfbo4=;
	b=CfBR3F12O2M7JrTJTs9zmVvFWYThnla98ZtooIruufJ2jDIZnR5iv3iSKNn8soPiAqFJ
	 iqENw7pGQZ4D4zx+v9DkjEpN3YFB9QUj/1sEhQao8Tr6zeZ+ymPiSXV80zw/5wtNtWwDF
	 eivrSHb2KWiAvtW369C86fZxZ7S1g0slexP6YBwU5Fpi6siK4C5dWqK5XhJTl1/cfNf2P
	 Ep2Uy73KPD4YKlxYRz1hfH3I97skxl7qX3cLkQX92XAq+uji4lLZHzb8XMm/5aord5Ke6
	 q1miyX6/yzyiQrqicSZV2IYANwMm0+DEOw16YeJS+u2zL5Y5+5Lae5kPSUcScfUrciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8oA2H1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4C606A521;
	Fri, 20 Nov 2026 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8oA2H1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0695B1F000CA;
	Fri, 20 Nov 2026 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154869;
	bh=+Q/Sp05AiIZSb9V9uY0yDUF0lL9up7p30RJjOrcfbo4=;
	h=From:To:Cc:Subject:Date;
	b=b8oA2H1wrVN/rA89/9EkhaZutna86qhgM8ktwmiydVOErWOPhIzvUq0FOeqU8NyGN
	 7S+SO2AgIcpZViYJt2TqP7PFgcrIJkJ3RwTblyuAMo5DIcY8oFc/VzmIQZPh5dbubg
	 o9eogkNzHTAw3mvZXnJ051K38Udfq3sIUAucbpP17Rz6ULuOj45DbWnK1tqh8QZ5rd
	 rYmooDiXghFeZQW/vls97sdGymLHw9J9OLMoDLokgoLAfjlehkdHcw+JK9n9qyc9zF
	 RFmt6A/soWKxM6h36q7plHKfI/TVK3XuHmI8zn0mDcPLvaSUwMQxAF9ic8cn4uEY6p
	 32q0NV5gCBHsA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon/reclaim: enable auto-tuning features by default
Date: Thu, 19 Nov 2026 22:07:34 -0800
Message-ID: <20261120060741.92121-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial version of DAMON_RECLAIM was supposed to be used after
manual tuning of its parameters.  Among the parameters, the monitoring
intervals (sample_interval and aggr_interval) and the coldness threshold
(min_age) are particularly important to be optimally tuned.  The optimum
values for the parameters tend to be highly dependent on the workload
and the system.  Hence no small amount of tuning efforts are required to
each DAMON_RECLAIM use case.

To reduce the tuning efforts, we recently introduced two auto-tuning
features.  Intervals auto-tuning (autotune_monitoring_intervals)
automatically tunes monitoring intervals to provide practical and
efficient monitoring results.  PSI-driven quota auto-tuning
(quota_autotune_feedback) automatically tunes the coldness threshold.

Because the auto-tuning features were introduced after the initial
version, the features are disabled by default.  That is to keep the
default behaviors unchanged.  However, enabling the auto-tuning features
is only expected to provide more benefit to the users.  Disabling those
by default only makes the adoption of the features slow.  Also, it is
difficult to imagine real users who use DAMON_RECLAIM with its default
parameter values.

Enable the auto-tuning features by default.  For PSI-driven coldness
threshold auto-tuning, set 0.05% memory pressure ratio as the target.
Free memory ratio based reclaim watermarks were introduced as a safe
guard for unoptimized coldness threshold.  Because it is now reasonably
auto-tuned, disable the watermark feature by default.

Enable the monitoring intervals auto-tuning and PSI-driven coldness
threshold auto-tuning via patches 1 and 2, respectively.  Disable the
free memory ratio based watermarks via patch 3.  Finally update the user
document to reflect the changed default values, via patch 4.

SJ Park (4):
  mm/damon/reclaim: enable monitoring intervals auto-tune by default
  mm/damon/reclaim: set memory PSI 0.05% as default quota goal
  mm/damon/reclaim: disable watermarks by default
  Docs/admin-guide/mm/damon/reclaim: update for changed default
    parameters

 Documentation/admin-guide/mm/damon/reclaim.rst |  7 ++++---
 mm/damon/reclaim.c                             | 15 ++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)


base-commit: 0ec5c1c237bdf91ae93b3efe32767aad9a670f8a
-- 
2.47.3
