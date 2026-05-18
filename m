Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011038F95A
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131549; cv=none; b=Kbm7oCQOjbrBcaKC+Keowz0OXpvfjrA+NOWHrDsvGpLeWJd5luEJEwrohu9K3NaqSje+jXfa8hq34VlQmszR9InikrGwmTjWWwEesPoh/UQ1YnqEcTSkEmMNujF/hS9KuyptUwdJ3TI1pPN0cSDlS5dCI2D9wh29FcH85WwHaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131549; c=relaxed/simple;
	bh=rrpVVM/TXd2iBehI82iGkh/E/IqrUjKfYzsy7IZjmKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diJGHx+E5XlC4ZY3gfByNUnELLtffsOLxZ1DcrI6kjFRNSHmQ/emX/1XJ1SVyHXIG5ki5kGtAsH5yyy+kdSPtIL4YEZ8vI80B2Wg5mztJfUZLgmmwOpe+dxzEU0nJxohlwRgpDNwuXJT89ykf800SdHZUzagSiM+HunSzXArBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxYgMWfQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxYgMWfQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so1047680f8f.1
        for <damon@lists.linux.dev>; Mon, 18 May 2026 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131547; x=1779736347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBC6NBfwX3+M9N5z8/EgZVcnEG4Grml2tle9vPR+gqU=;
        b=TxYgMWfQTpYayOATMmcKR6yp2MhwcOw15YiwGb6Y7ankF4ydff4xJxryo+U2jI6Smn
         VN/Xm6BfQ22urC6oxGG9ivWqb4HxCfQTINRdn8faaGndY287bZhXYl9x7ePst7dXwDyd
         BiBqZbmnLbRYTFZxMMFA+DN+PmBG8jgLgDSwQaE/P6X715gBvQ6pzAZNOFP2f+zQDA9W
         TpJI1GZ7V18kBU+kfgFWiLhb4t0oG7dRX4Nf1vTqEP1XWwNwXMMwCgwQ6GU9jCJzskUt
         rrD+43+JzsaeOXlU0x+0H7IO1+RxL3YBrIAQg6YNC1WYdVJnkKkoGtHUiRhB65kkk/Vt
         2law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131547; x=1779736347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBC6NBfwX3+M9N5z8/EgZVcnEG4Grml2tle9vPR+gqU=;
        b=mIcQrk0Nb/jvga7/1yiaiV3DPeEsjwZoIpP60YtiAblb6ByMlCXjEuIiRlG1BUdI5C
         T6tKdsZkv7OGHnPpABDMsE9BxfgrB228iZufnBOSH06dFaCxtKElexoXCHM+HC0wu9fG
         RBcT5t2Rz/2U2N/Nxl7eDtuP/4shFCiynFhN+nQ5t5uA3SyljGOXi7eEv9jZpXC+g1bz
         zhmduo/7awM6OzH+cKM3h3NsmUNU8M3YBlAMytmGqYfPBttSHr8uj5UEl1eFApmadNT6
         w3wIGBll4sXcRzbFltpgxvakx/99pw/Aw0Kv+m4NNLrnVxlnsoulvrMltJvpzLsCMszy
         lwsA==
X-Forwarded-Encrypted: i=1; AFNElJ89k86DzMybtJRTYktJKbb6GEt1MC4BoUSFwVfVK0NUpPUg69RxsdEzylUUReWGQqoFsvMDHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx++a07brkVvqLB/+jwxP7qM59yqolBmjuYb6+1RkFV/NVPuRGA
	X4JY3N/Z18Oc16dlnhaso8giH6uF8NVd6QRCEfax7Ve7VnozNeG9IUdX
X-Gm-Gg: Acq92OGZ3zOLxZ5FzAf10tJCid+BrKF1QAdp9IJy2qD3rcbIBx22LbP9S9TIP8ubraq
	PFQ4mC4h2v64eUR1AFCioO5HJp4sLq3/ptywa1y7CHYGSH8x0UdX82mLy0p3r0s2ay7fBSFFAEF
	Y4l2CyEH6utYcWQW8AuoX0SnzqLY2shqqgEnixDSGM8jHMHBUePeOuyzEocAwdkPLPwdTJjL/IR
	pe8d3r+AZXU8ZcSRZP+kGY4HjlrNpK95HtZuV4IrQ8yF/jhvFB0/sYSEWUoAnAdeTRmJ/ZxGTLL
	HpSdS+bqRw7J36M822M+KmB367qjwObeyS/v2akMw711mGrpaRd/xeyO4QjYBLdlBkmylC9xAXw
	zm15rtn4gCDUmC7nSufGOitKvS3HObPV9NG7qZ1LtmeEd6zYH0R53dj/k5rDlyYHVy3v6ePC079
	oGjgNHOlGjObK3zLrjcAVrLonGZUSIWsM//j0g0rOgGR+AU9Ff0/U=
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45e5c5cc2b5mr26469781f8f.19.1779131546344;
        Mon, 18 May 2026 12:12:26 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm40043167f8f.34.2026.05.18.12.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:26 -0700 (PDT)
From: Maksym Shcherba <mshcherba2000@gmail.com>
X-Google-Original-From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Subject: [PATCH 5/6] selftests/damon/_damon_sysfs: support update_schemes_quota_goals
Date: Mon, 18 May 2026 22:09:31 +0300
Message-Id: <20260518190932.42270-5-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
References: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add update_schemes_quota_goals() method to the Kdamond class in
_damon_sysfs.py, which writes 'update_schemes_quota_goals' to the state
file and reads back the current_value of each quota goal.

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 8b12cc048440..27cd94683f6d 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -806,6 +806,21 @@ class Kdamond:
                     goal.effective_bytes = int(content)
         return None
 
+    def update_schemes_quota_goals(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'),
+                         'update_schemes_quota_goals')
+        if err is not None:
+            return err
+        for context in self.contexts:
+            for scheme in context.schemes:
+                for goal in scheme.quota.goals:
+                    content, err = read_file(
+                            os.path.join(goal.sysfs_dir(), 'current_value'))
+                    if err is not None:
+                        return err
+                    goal.current_value = int(content)
+        return None
+
     def commit(self):
         nr_contexts_file = os.path.join(self.sysfs_dir(),
                 'contexts', 'nr_contexts')
-- 
2.43.0

