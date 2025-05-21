Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D522F763;
	Wed, 21 May 2025 04:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801683; cv=none; b=sOoRxna0JS7yRzjmT2dR5MTheY7IpbF2rt7F62uDEu3Z12rPLwsxD7ZoggvESpQsJuODtneo/d5UPve9Jxq2NChWkyOi72jbmCW5G76/cnLK3V7faoEwGIgnFIUHX3Lk7qryOx83eQeRxCAOIY9fYPguj7ZJxGZJ4jR431WxMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801683; c=relaxed/simple;
	bh=sJuZmUEpnnj0eEyv5BwTCfrMZ311x7yMVtk9He0E/2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIgC6POf6TDv8ou3u2EAMeArNUUvPwE08KBXkz7JN7fNCXr0YmIKa8f/9WhGRTH4Q9px0FOq0slm6DT80nqx/02tykzKURpB0b6Zteaw7tkkTF8gSGuSayBXbbqhubwdveTDPY2pnafDObY0d/kzRf1nTIV8KtnEWRVrQcbT4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoOyK7uJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoOyK7uJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380D9C4CEF4;
	Wed, 21 May 2025 04:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747801682;
	bh=sJuZmUEpnnj0eEyv5BwTCfrMZ311x7yMVtk9He0E/2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UoOyK7uJdoSQSaL7/U/4K7p6qbEJPMlXXQKz1oV7p7qr1JYL1RWsYKBNsC8CF4HtY
	 JuY9ndNtBdyQ8zzfe42vDhWZrWo89kapuryYwKJI084FYa6k4DWQ++0vdrSNstI7Ev
	 iHRDPwNF4FyaAe4+lDAb0TR3/vTBSY2NJWT1WxxMN7DIjeHAJzfqZRHOvILlfvB879
	 jv5rwDrJtmZ94jwkc1Hx8afdd+lrq1jaubs8mulhahvML08K1o2ud9tjwud+y5gjjT
	 62HK6sBghb2qzeqd9l34F3Fi1P/rlLhzSBPJE4Aw2GslAPfPM4+RcWfC79riaWhYra
	 23csE1EWvK22w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/Kconfig: enable CONFIG_DAMON by default
Date: Tue, 20 May 2025 21:27:55 -0700
Message-Id: <20250521042755.39653-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521042755.39653-1-sj@kernel.org>
References: <20250521042755.39653-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of this writing, multiple major distros including Alma, Amazon,
Android, CentOS, Debian, Fedora, and Oracle are build-enabling DAMON
(set CONFIG_DAMON[1]).  Enabling it by default will save configuration
setup time for the current and future DAMON users.

Build-enabling DAMON does not introduce a real risk since it makes no
behavioral change by default.  It requires explicit user requests to do
anything.  Only one potential risk is making the size of the kernel a
little bit larger.  On a production-purpose configuration, it increases
the resulting kernel package size by about 0.1 % of the final package
file.  I believe that's too small to be a real problem in common setups.

Hence, the benefit of enabling CONFIG_DAMON outweighs the potential
risk.  Set CONFIG_DAMON by default.

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index c93d0c56b963..551745df011b 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -4,6 +4,7 @@ menu "Data Access Monitoring"
 
 config DAMON
 	bool "DAMON: Data Access Monitoring Framework"
+	default y
 	help
 	  This builds a framework that allows kernel subsystems to monitor
 	  access frequency of each memory region. The information can be useful
-- 
2.39.5
