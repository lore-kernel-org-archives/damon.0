Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF812C9D
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308448; cv=none; b=lDs2BlOtQaYJeqYRMvbiv01+jG9Aj6xeTmKVEc0kI8MO5LdsyX1ZHA4ACZxAL4Xfgwq0tUT/oL8ePgYQN+EhAVDDdCkxsdaTExDfQby0YS5wJUV0mIYTxlS/28yddWlVbzea8bk6VrCRD0gpZbqiupCH+QJBNLqNg6Xp5J54j2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308448; c=relaxed/simple;
	bh=xEywX6mLKVJuXX/T+0uj3bA9TJABB/Tq+t8KSDhgJf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XK8I0hcTClArSW9iLMPPIsiOmkB/jlNJ0rUlfnhCIgKv+EbkhAkyEatYPFjPaHGXBT0xOQ5MNiBxNhsolgwUW7xgyDz1lzBrA2ViulBwtH9JVIP1QqvKg1izQ9dBRl8gqWnq4cTNRqkVnS6IbBwf7XTAt4t+q4lrxfjJXaLFQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffboakyQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffboakyQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e05b3eso1881309a91.2
        for <damon@lists.linux.dev>; Fri, 15 Aug 2025 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755308446; x=1755913246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=paq/IdzHGLOy+RGY7FtKr+S2+lm7qcZDiB17Sluzsd0=;
        b=ffboakyQcirKqhCsjiQYOr8a/IkcgpbqOBq0xJ0uYG209NtV//Dc57JUnC5Z0/2WCy
         kKuLva6ID1zENAL5a8jXnlPpytgoQO6KXL08Iu8BlizI9xDl654aWvwdFtZG1H7fMQOl
         wxVyiOGyAsMBFL7DxdA2FyN9s8C4GjjWxezBuk8oW1IGzem080G5NdL2BmZYHx08bd1V
         4mfX9JZr96c39HEs4eyiTf3+GN3zeqoTXEp9gBp7d/NwExBk7IrD+CsqAjvpzTUwc7HY
         14tFy3+PjeUnL8rGcjjwW5nWdlUK0YZmwACYhk+4OmRa5qW6vY2xXUSo+e99PkQwzr8l
         iYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755308446; x=1755913246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paq/IdzHGLOy+RGY7FtKr+S2+lm7qcZDiB17Sluzsd0=;
        b=em/xyHUYkLcbcSYTqlrKvxjbw7oePgiv5wnC0lNjbKjISkBiiDVbZYSm2YsJr0BHJC
         iHVcmXI11QULkgOXY/KWHun0tw/0wzErPxfUtKZSwoxKqklv+qX/8DvcOol/mKviqxyy
         8lNdXAdG6o4IIkNkkjyOqCpw5wURlwY8J9eUYpUa+XGVDiwUcd9GV0T96au41/Os1nlT
         8ZL6Rx56tce9dlnER5iMRavDlCQq4s4o1sCKAVV/XGzQF4slRKwnHpo2L3GcmlPH0+MD
         X2JZY/KqEpL7dthDsyQoJUL/kCq320Ga45inMG/6Ndv1ZxNW+NcFLNy3bBeXHRo/rUEX
         g5XA==
X-Gm-Message-State: AOJu0YzP5F5oeCorM3zvZuGQzQxgGleeCSixxguq7iSpKG/vdEEWNMg7
	rRaZQdsxXz6MELIiRf1VtuG1TS6uc2iz/Zpzf1btEIob9whkrxARH8W2
X-Gm-Gg: ASbGncvk+iducwlYJoWkiBUjBIo2JRdqZxDknNy/VisKnM9/1pvbH8lZS0Mjn0IuNmU
	m5D7GFoO/5w4AIZpdn/iLXMRk2gcD3bvfP7PYrEJIwCa04n/4sYXHwPaxkW909Mn88hMT0SpPUC
	WetFeScdBw41B3OveI453DpCo5JQjpZssbDfmX01HM14sbhaBf9o64rHRTwuwqXiXe46QCo8OL8
	4fIGDjtCC4vmBLlDusBUh6kptg/PM5w2QHnFoewRMZdcyVSVQqs/6aKlaTZcvtMY+LUQT8U2kNp
	Dm9aiH13JZ/ydcbvVpgMoXX3LLXrhVxvaHe2MyE90QNq0dMufd0v9HFhjBrUFGFAV2EByyHV5+h
	NFHAxrZ2hWVwLhed0pqXEaCjRtxM=
X-Google-Smtp-Source: AGHT+IEldIYgUTPBqs2QmokMM903macHwQZdSbaxDJzg3Sh/WqP1PBIrJOtUGSrl/jElEKFStjgRtg==
X-Received: by 2002:a17:90a:dfcb:b0:31e:eff1:71a5 with SMTP id 98e67ed59e1d1-3234210439cmr5067770a91.29.1755308446042;
        Fri, 15 Aug 2025 18:40:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76f9e0sm2324227a12.44.2025.08.15.18.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:40:45 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2 mm-unstable] selftests/damon: change wrong json.dump usage to json.dumps
Date: Sat, 16 Aug 2025 10:40:33 +0900
Message-ID: <20250816014033.190451-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To print drgn status to stdout json.dumps should be used without
json.dump. Change incorrect function call by typo.

Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON status") # mm-unstable
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
- Change patch subject with DAMON convention 
- Add branch hint to fixes section

[1] https://lore.kernel.org/damon/20250815094029.133063-1-ekffu200098@gmail.com/

---
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index f557587ebc81..2c65cffe6b54 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -62,8 +62,8 @@ def main():
         exit(1)
 
     if before_commit_status != after_commit_status:
-        print(f'before: {json.dump(before_commit_status, indent=2)}')
-        print(f'after: {json.dump(after_commit_status, indent=2)}')
+        print(f'before: {json.dumps(before_commit_status, indent=2)}')
+        print(f'after: {json.dumps(after_commit_status, indent=2)}')
         exit(1)
 
     kdamonds.stop()
-- 
2.43.0

