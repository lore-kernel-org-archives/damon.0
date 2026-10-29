Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263358;
	b=PaYd9lYyPdZGHaGzfDwaagybPbS7GONWbmecvsnJKf5XOX5aQoBufdxQeX7/jAXxA1zQ
	 Vr06PIQJ3eHdHtXLWpD6IXKrw8ym+b1UXMxv+KE7TW7icWC3+ZVvmNPhkL/MZgj4JJGRy
	 YABcl73C0wzIty0ZmmFjFRpYBGvJC6AmaqSBs4T8NuxNXdm4LYiHAucS/HEaUbRNPZgc1
	 AKT3NMCeG/aFyWeUFIM1BlyXfv0QPs/BUL4pBnWhHpPvtsQdYAE7Dn56G4Xh4BZJRyTJL
	 1gRuo2smOLc1FZrvriqmQJ9CZBH655nCA4bK7ovAcEFuh8jcHeh8EwWgxfZBVwxWrBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eJN7tODtM96gshRP+uJBFf1UOunuTrvylT+4Jwns9+g=;
	b=1izh80/znl781CQ0jnsG3HhPelAlQujc59lDfAhP/cT4f71/txOA97VM2Ve+V/6a84yY
	 aCIPOQbuqLjn1sdN+05F22Af7YD3xe+lx6Y9hsw8Fv7EUSD7eUmICGWscRHPqLwT5mJjC
	 C9eeBC+vADFbjC5/ks8jOHzd+mQeh6WdQiCDGPrFCSv596T3OIVDYVjMxs+3C4Zm6V83d
	 Dlh1G39LiuF4wZnXRHYnVmTw2xakHYV1n0xJB2bGoxl3Qc11aC/t4/2A9DdVhiPjgjg2e
	 qWolxszdYFsUsrocOzRQ2rQVxd456ivTs6RNtExFdvRao9CHqcCLBHLC88FrDq+8igw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ft67Hcu1;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A82606A31F
	for <damon@lists.linux.dev>; Thu, 29 Oct 2026 08:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A82606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ft67Hcu1
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1035140b3a.0
        for <damon@lists.linux.dev>; Thu, 29 Oct 2026 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263357; x=1793868157; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJN7tODtM96gshRP+uJBFf1UOunuTrvylT+4Jwns9+g=;
        b=ft67Hcu1ahC2emFZLPJNXGXXS5onotHvVXleknW7go9J81F04sHmYiNUdgdo3v0GPQ
         uTPsBgcniALyA6lywL9rHwcd/lN1ZudK9roPD00GOFmV0qg3143ead9N9QoIDpRCl82L
         pFN030ou3Yq1bWpEpjSklZOgnDMSt3ULhaYV0LrY5jYHQgfO6feptreb2FJC9XS8r1F4
         erOhsCZrt01NLx98FW5qLIKZKuoVAKmXgRnQ1nGMChYp5iDpKQ4wurVrw8QB0HiYUUZe
         RMQDMqFQgj432y1TiUYORQCxiEObmZ6iodMb8iUV2PL5JlzXu92268QqcB/AqLNflOfr
         ePHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263357; x=1793868157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJN7tODtM96gshRP+uJBFf1UOunuTrvylT+4Jwns9+g=;
        b=oGCJB5ijIk02MmOYpjifDA5vsx61RPgF8ULDdykjWEhe/v/IEdhv0mLeLx3ia32GPi
         0sLUIXoMb4LAyU8UWdkp6z6Vw0K8X74NLPFjSqF4+rTdZwXB4h3Opa0j5Bpl65xEvV8V
         ezkMC/f2d+1+d8jUADRble+iYFD02Hfis9a67Gd+e1QdC3A1r6SxwS7QHfeWU7EUoKLh
         0h1/J7t4YuslANpwI87lsYe6NhJENKDqHy7sDVrvIE+vSqw/VoU+XTEslMrORtFxw/kd
         iV00dPLyrYdia3gu2/mYYAtjFTA5Fe11k6/DBO3UiDz0rH5K3gB1wLVPHOmCoaTcLRbX
         DSlw==
X-Gm-Message-State: AFq9FYLe0Yyd7n/YsD+56vXo4ZCSNmoiGiTJPTHh7SVx1bhe8Aa66lRj
	t7OOlai9Khzgk3xj+3IWupfhzZwgMtVU5lUkj3UKMfTRRdzBSBH+uk1e
X-Gm-Gg: AYBFou0DzbFnJpcrGEMa/Fe09YQ+/H3Av6f6Vs2DRBcXz7Aaoy3b9zB3m1TPPnE1jQO
	8TO7DGvckcZvOsiT/3Qgz3STy3Lbn4GM6sHAvvBF9DWvK6Ozj7XwUcgE6XM0axmCwq80jStWejz
	9V3Ifrq2f1ZFO3x3Ey5ji2iqvm5o03H+yVg/raCCHo5qPFt/b7mJKzi3enHFIzD4eB898xEFQ4p
	XPtM9nVJaOV55r7GY9Myu4wzg+prWGDA/T0XXNgx+uIWrQv4GI1jN0j9prY9Q/q33ubu5nIzLDv
	kWSZ/H2CXN84CGbD0U9jVS8HBr930tcGCppWu4ZmQ2yv+RtaswDSkaAxes4lHG0Bqe+Fh4uEaiR
	6t5n46zpgwh5V1yggZgF/qK4a3mriyM644RUwZQS7nv8N52WNTzV7v8HtTT5qI/q/xU/BeyoTCJ
	sEMDJPqjcg8gReu3otS52+GR0XbD6kWBu/TL7xOTiCPQkkK/oCNTebyOa5EjDfTNlUFZ4RKP4in
	q/Kc/OJ6f0Os1UjVfK+4d3XX/vE82yXr1AA5L9Db2c5QnI7lHOFEXUCJM6yt7fEJXhgPFEchZzt
	PBn5R+l3D9gFCBfkWlkYKRzsIgZvieEIdZLOLLYiSWl568GO5B1gvZqLD5meD6VXFtOK
X-Received: by 2002:a05:6a20:244e:b0:3e1:af52:6d06 with SMTP id adf61e73a8af0-3e9023bdcb8mr4276472637.52.1793263357282;
        Thu, 29 Oct 2026 01:42:37 -0700 (PDT)
Received: from xiaolei-VMware-Virtual-Platform ([219.142.21.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdacea7938bsm3338029a12.27.2026.10.29.01.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:42:36 -0700 (PDT)
From: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	error27@gmail.com,
	xiaoleiwangxiaolei@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <liam@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH v2] mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets test
Date: Thu, 29 Oct 2026 15:56:09 +0800
Message-ID: <20261029075609.35661-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

damon_sysfs_test_add_targets() creates its monitoring context with
damon_new_ctx(), which leaves ctx->ops zero-initialized.  Since
DAMON_OPS_VADDR is zero, damon_target_has_pid() returns true for the
context, and damon_sysfs_add_targets() therefore calls
damon_set_target_pid() for each target it adds.  That function grabs a
reference to the target's struct pid via find_get_pid().

The test then tears the context down with damon_destroy_ctx(), which
releases such a reference from ctx->ops.cleanup_target().  For the vaddr
operations set that callback is damon_va_cleanup_target(), and it is the
only place where the reference is put.  The test never selects an
operations set, though, so cleanup_target is NULL and both references --
one for each of the two damon_sysfs_add_targets() calls -- are leaked on
every run of the test.  Running the test with CONFIG_DEBUG_KMEMLEAK
enabled reports the leaked struct pid objects as unreferenced.

Fix this by selecting the vaddr operations set for the context before
adding the targets, mirroring what the sysfs interface does.
damon_select_ops() fails if the vaddr operations set is not registered,
in which case the test cannot exercise the pid handling and skips
itself.

Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
---

Changes in v2:
- Fix ctx leak in the vaddr-not-registered error path
  (reported by Sashiko AI review)
- Link to v1:
  https://patchwork.kernel.org/project/linux-mm/patch/20261029015725.17378-1-xiaoleiwangxiaolei@gmail.com/

 mm/damon/tests/sysfs-kunit.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 138a4b8d14e7..16373ba751db 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -79,6 +79,15 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 		kunit_skip(test, "ctx alloc fail");
 	}
 
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		kfree(sysfs_targets->targets_arr);
+		kfree(sysfs_targets);
+		kfree(sysfs_target->regions);
+		kfree(sysfs_target);
+		kunit_skip(test, "vaddr ops not registered");
+	}
+
 	damon_sysfs_add_targets(ctx, sysfs_targets);
 	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
 
-- 
2.53.0

