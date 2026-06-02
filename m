Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A863E008F
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405942; cv=none; b=Qgn3UhU/uqitJ/2PcMNwDjWYZikPhAOcYrptLX3zgbly0aMTl3Y27XvE+oBKpDLpIVyo8NsG2UgvMdz5cVmIoaLAnKuy4URy70glzox3E/K7WNLsPyLtW4Gya12q4ynKLlbBuXxaHX4JWXRjGZ/SPLbNvdEuNmSmI5ujmFAVNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405942; c=relaxed/simple;
	bh=LWPMj7a+gzLg7XA9kVfxOsUzy221Pa84w68ETkj7T+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv7TkUYcHec3/rJRJSKbNOctIC8HaBwSWJht+GSGVDTsjyKdcwd/CmbMPeMPwMV3/gYwqWGbfRxU+SJacQjx2NH1UoAdbg2Plb1t9QkephVONcKFtNpu2TD6CQ1Wp1fxe4a4ISyHCdn6tytAJjos2H6scagKMqIcQdvtES5f7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkCsT24S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkCsT24S"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eec22fab7so2808388f8f.3
        for <damon@lists.linux.dev>; Tue, 02 Jun 2026 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405940; x=1781010740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi0nkd00qoOiTXwyNBhW7SD2eFbz6g/U1mZvPVWCOeM=;
        b=GkCsT24S5L0Q2S+5oCTOnnQGWC822ukXGPLCGA1KI8430GshTDKW/FZGOQkWDtvcnV
         JLzN93ccEbVzFe9P4pljc9MClWlEjvrRWNecVl94oAi3OK/ISIj0mcjmJx2rh/lAMHZW
         Yf0Lmy5HV7CiTTeZkJ7kNMlkYFYxf7dTnlvBDM3FNRxVN0g9H6g68vVgbxsUpovq6W1C
         sFNtrpTB7p2bwiHHfQ9dHTVeRh+3HMgarbO2+HOm2tTF9aCq41e65g116aUzCQgWJXe0
         BrcWQzzUec/mlYsVaiBpdrA62nn7FHDwfRnUC9Pz93lgZF17jfOHh0HJ1HZURq6KYhWd
         e3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405940; x=1781010740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gi0nkd00qoOiTXwyNBhW7SD2eFbz6g/U1mZvPVWCOeM=;
        b=pt/4s9yIxwZaCyABj2MW3ZQHFnR1rmDLh3qtqp0OTAt/HBFfKnuWUDaG9eWMd2ftyH
         dIOLcBzAg69ZAgm00XVEn12/oCWOrn0T+MY2PNanti8unXHskpxjjI6p4UDboUSApsxA
         IMKrkEkyxaH7p4sQCSC5FWhBhauJDk4gXNF1Mc2HvorJ4ZSvD91cbcPehvFzP8kL1hia
         8ETk3JxPnPjDeU4y8SGoequ7DcaqE2BCaeYTVnLdF5vOJQqtYP0uPOD1N/MSaNixBPGS
         6ii15V0rE9h45xwFev7PmHQ1d1+aGSfPSoKMTWO34YtU/LSP3YSKeAV++NVh/txu80I4
         NvkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kiD4aMMMTrgLs7NsxETuJSIfScX2HxTlrhIMsH05QPbAi28M8hmRp+/fq77vGE+6dV7AHQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCzr15ryH1Cu+cHejgBtc0pYzXKgNaVq6hFScWOIvd0EjUFZPP
	2MdsNY+hioWD8zBi54KyxgXiSpIS6XTnzDCuVP/pH3SUrPGcUt13O5KP
X-Gm-Gg: Acq92OGulU/UGPTY6iMFOGFvary/uOwRYbQhFclU1dCAKemLhB475df61s6Ytl8GXCg
	KT8O66awu6ywQFqO9pwyUPAxyCDD5gB8l0FSKF4c83ErTBuJpc4BbLl2Zm1QxIDBR+bjJ7sICgy
	7S2DHwKNE9E0w7KMCc+giv/UWAHnhG9/zKSQk/16cJLIZ7XcJJnFR7s9C8PzbBv68No0yahM7vz
	zO3DG/CI1lPkoOopWv5PXQ95BcCQZQOVAicNkNaa/+ozKA0TC/Gx2PccnuIJDfiGCqe/Dr2AN0y
	u65HoHhmfHdAAFuYi/PbM0LpyseXJMqbazycHSitxzQJR9kkSxtFJMenVajbaJgL7ZT53lL9aeB
	b9LscKnvl/8uFBNsnUIteL8S/yJSJgHO56gunxKIfDNIiaoqOT3HsXdnt2+KPoa2EWyh1hXfToC
	bNBDoZ3N8IvGM/8DtYNNnh8MWI1PeRefkkH6M1F2uZyg==
X-Received: by 2002:a5d:50ce:0:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-45ef6b18708mr24074083f8f.12.1780405939786;
        Tue, 02 Jun 2026 06:12:19 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm33234665f8f.15.2026.06.02.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:12:19 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxoid@gmail.com
Subject: [PATCH 1/2] selftests/damon/_damon_sysfs: support kdamond refresh_ms
Date: Tue,  2 Jun 2026 15:12:16 +0200
Message-ID: <20260602131217.2210912-2-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602131217.2210912-1-linuxoid@gmail.com>
References: <20260602131217.2210912-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kdamond class has no way to set the kdamond-level 'refresh_ms' sysfs
file, which makes DAMON periodically update the read-only sysfs files
(DAMOS stats, tuned monitoring intervals and the kdamond pid) on its own.

Add a 'refresh_ms' parameter to Kdamond.  When it is set (including to
zero, to disable the periodic update), write it before turning the
kdamond on, so tests can exercise the auto-update behavior.  Leaving it
unset keeps the previous behavior of not touching the file, so callers
running against kernels without the feature are unaffected.

Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2b4df655d9fd0..1a498c78a4149 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -667,12 +667,14 @@ class DamonCtx:
 class Kdamond:
     state = None
     pid = None
+    refresh_ms = None
     contexts = None
     idx = None      # index of this kdamond between siblings
     kdamonds = None # parent
 
-    def __init__(self, contexts=[]):
+    def __init__(self, contexts=[], refresh_ms=None):
         self.contexts = contexts
+        self.refresh_ms = refresh_ms
         for idx, context in enumerate(self.contexts):
             context.idx = idx
             context.kdamond = self
@@ -695,6 +697,11 @@ class Kdamond:
             err = context.stage()
             if err is not None:
                 return err
+        if self.refresh_ms is not None:
+            err = write_file(os.path.join(self.sysfs_dir(), 'refresh_ms'),
+                             '%d' % self.refresh_ms)
+            if err is not None:
+                return err
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         if err is not None:
             return err
-- 
2.43.0

