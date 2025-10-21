Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707B2C376B
	for <damon@lists.linux.dev>; Mon, 20 Oct 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993282; cv=none; b=j3YSaLd9VorY2KUX14A9E0wGJ242CUYRb27/rqI4ckZP8U1C/F04RtNQZ4M7NiOcJbXjdTighvLNiGmpMBAu1OJ175+XZd4VgjmHpLc4PVKT/s79KKe+srdZxH/7qlVENFHDAYJjwWfhfNp171iPUGJr4z12FUqpXCsOTDgqoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993282; c=relaxed/simple;
	bh=+lQWjylLhy1i02VSP0o8EBAfjzoQ3wmltcvC6mtbneM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pr+FDkDpSrTBe0x9WQH2PGWGsfofUwte0NJ4xisi0nnDzEFdC8hvjLvLEMjColDjOIB7bE3s9rVfdZ4VZnjNBBD7k7xFpTYNBOxKm2kSSfxHBPpRO56MAJPq3ELoejljiMbxwIGhtfvXT0f5Qjvcek1HfFguP7TVyjaL4w+qlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1Tc9Vgl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1Tc9Vgl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27ee41e074dso56784095ad.1
        for <damon@lists.linux.dev>; Mon, 20 Oct 2025 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760993280; x=1761598080; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9q3clnG/Bkvn7l3sw7E6dauVwm40zMq9FQvMaqCBk4=;
        b=e1Tc9VglPWIMqv+6T7VJ4B77aUh3xsJUMmDIhlngpTR47cHI9y1OBbyoHBbXH1XBUn
         6dzUeDKhbMzI83fSoJzCoHzuDrPr5ArJ6u1d2lp71wd0uUlUSNU4ayXFO5Mht21oG8Of
         Q43PtCTNM6StVvPp4wbZfNNvxD1H+VQOpkxE5Vb91IhbKaDpEro3DewapZf9C0KhhmZ9
         OHXnuRBQFxeV3aN5A4CL48CI6A0hGxVczxP0Di7wG5vH8wMgO8GEW1Deg8ms676o0csU
         sJ+7JDMZWNVC9gdbrXOsmn+Ek1EvfO0p3ht5vyAl8pT6yTZc6FouUxoaBm59pEpvTCYY
         Icbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993280; x=1761598080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9q3clnG/Bkvn7l3sw7E6dauVwm40zMq9FQvMaqCBk4=;
        b=YCW/Ei8tQR2D4dSJ/tPG9Tk3+R+KlDN0HtqBD7UPdu6CtVls/v0BmyxmoS6e5yoMlf
         MR5KIkaVCGAiJaKMcemwdPsdLDbnsv5o+QHVbjusmp9tr/rZAYJlOS33fK663pzmA23w
         u6xLmgnYJvCMs4BimYjp85mdL2iAuaqD/MVFLwsiYFC/BCexXtxQpHzsF6zaeW0eqn6R
         upvw2uV53g+frVaZnOdK6mkpTOWXYQK6hJL8RI+RCgM0bmflrn1hUfspAdzKLE72E9Xz
         dwAHPNB1WfETwkZu6cWo+GC2XClklQEHBGnwcBAEC29QQmH+BucyluqKrKq5lfW2zKsM
         42Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUdAKLQz0Z9xjjY/VHWzu4lxp1QOVWsjY981O8gHOZX4fEzpPyRLR6+0VpKBTnLcJWZ93w4CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5/iAFoRKhQw/fqt8wKuFB31qnh11o+b8CKOlgWK6aU0G4e1X6
	xA0v7Coz5+DeNim++oB7k1B6MSXylXMAmAD/7g+F8P3JDx90khuD7K/8
X-Gm-Gg: ASbGncuGYkDlFz0aG+Hq4mYarpw1KZQjJ5c4VYuBOqjbQUJtluoxy+8mPLji7Jumk5s
	xYJUk8zXWf3lEy1S9+WeK6G5To4Rc3x2ZoZlsONZgm7gJAiZk59UTXs23UJu4FaJuJWmSy6zngO
	8/LrC0rUD//NMYfJyGb1VgdFFkbz4jrNG9bNY945uhWO8gNfI51NV/ptZ/8vPR9fC4Vr45ccAo+
	NTnDnWxIiDhdrpNRdktN4XczxA8KSbBCuntHg3dfFeAq5YES0yIi1IO7tsKcNY3EoPfQZOCXK/b
	g4LK2cbi2dhp7Oo8/maD/h2pFy05JKhxpZdVGVgS64RmnWPCCxDGWlUhH4rJbeJo6XAe/5FCx3G
	8hEAYOI5mLPeF9XVd3xjmaZad0WXdfgMsDmX/3Co7ojauxsjnhh3LpSJMhyvfY+xk8nnwfxsv/E
	/J+8bmLfDo
X-Google-Smtp-Source: AGHT+IE5e+ebTLo/EOuOY7XEa0TXekx7W1YXHb9P048rXvUtgRAvL3w238dOjBn2L0cKSl72dYYTtQ==
X-Received: by 2002:a17:903:22c1:b0:278:704:d6d0 with SMTP id d9443c01a7336-290c9cb2666mr188482125ad.19.1760993279652;
        Mon, 20 Oct 2025 13:47:59 -0700 (PDT)
Received: from LilGuy ([2409:40c2:102c:a203:e88a:758e:c83e:2ed0])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471fdcf9sm88461725ad.91.2025.10.20.13.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:47:59 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs: Remove misleading todo comment in nid_show()
Date: Tue, 21 Oct 2025 02:17:13 +0000
Message-ID: <20251021021712.59017-2-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment in nid_show() suggested returning an error if the goal was
not using nid. However, this comment was found to be inaccurate and misleading.
This patch removes the TODO comment without changing any existing behavior.

This change follows feedback from SJ who pointed out that wiring-order
independence is expected and the function should simply show the last set value.

No functional code changes were made.

Tested with KUnit:
- Built kernel with KUnit and DAMON sysfs tests enabled.
- Executed KUnit tests:
  ./kunit.py run --kunitconfig ./mm/mm/damon/tests/.kunitconfig
- All 25 tests passed, including damon_sysfs_test_add_targets.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Suggested-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..760279092b4f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1112,7 +1112,6 @@ static ssize_t nid_show(struct kobject *kobj,
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);

-	/* todo: return error if the goal is not using nid */

 	return sysfs_emit(buf, "%d\n", goal->nid);
 }

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
--
2.51.0

