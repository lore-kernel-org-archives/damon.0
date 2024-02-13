Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F81633F6
	for <damon@lists.linux.dev>; Tue, 13 Feb 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864423; cv=none; b=n7p2AA1ttbdmV+bqzR7XLJZiV/gebiCy+9Mtxc4jzFd5wkYkOk4MmEyfb15Vu7Xbb4hDmtaHULcKJAg3cZlFU7pb6tsDQTPXMA6fMiVWUAYHOoSyIr6g1nZ3LzXrBiQjdWzzQtH0nUqfQ50zqkA/oJ2JmNdDxI5HCp04T9NTu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864423; c=relaxed/simple;
	bh=LxI8B8lBhn/XmQtHholcJbNICjxQ6qBn1CW3zMr7+G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWBDTPGSz7OdyUE6Y2OcCjtvuOfFlhebdzALO3fBRDnzKr2TodXBsg643fAejTeXptRhIYQmkozQdrpWdGmRNqaU8wINmEQKxmq0RNjv1c8azjj7ebOPmW34wUld4Tp5dXZovwGP/QKJvcXtF8HeoEWcoMiKUhZ2eeHc5cnsf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP+7e3mY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP+7e3mY"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51176eb6a4bso5076197e87.3
        for <damon@lists.linux.dev>; Tue, 13 Feb 2024 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864420; x=1708469220; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP5efisalY835Gdkg7ANhnq12G2jME8WCLfPT0go4I8=;
        b=EP+7e3mYvJD5Jg409LRZjTFSVZHhtNFJpYw6wcYsovuiW37ocJi/VL2hQUuuYOtedi
         mDFygCWbCh2gsaVmIcOEZxnOJWSZDnJrNwxzIfkxgUERggHZb+PNAhktOyuW4s5XMQ+r
         vsi1oTX8F+U4rFzutInV8A2t/bxrR9PbQIc8eyzuYU1OCE5mX8E/OZGzXPO5ZemFgi60
         c4kBdV31Pm2F0rtVYX1fr+8ld3+z+ppxFWIj9bV3MmLntSgX6igKlv0jjgIKa2nLmzpa
         vA3pyB7lqlvkEW0EDkqP5ynNPZGOPdeUSqBH7xPrA1zbFbeGDHWADZ76m5fBDFMjdq7l
         ls2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864420; x=1708469220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP5efisalY835Gdkg7ANhnq12G2jME8WCLfPT0go4I8=;
        b=SrFnXhY7zykvpSxoTaS4B1ewTo787LFlEyeL2UORt192cdbfykBKY7ZYMHJ+Tck9ud
         8QlAIu/kw41hplbPvcQ8/2jYZ5Wr9OdmXCXi53Re1Hf1DxdweQCXet6wA+B3dijnAqnK
         wCTnSbAmn/eT49ONd4ZfwEuxlVng6Jc5+tGWAPSlllWIgmUBtKNn5zo+ewM4/LlttYT4
         k77QKxEHX1P0YLe4Dw3bXAJu/SKvDCGhhvvQ7q60IZ3fCMCemRRDVFSpje4nJGlxBr/I
         RjHPqISm8MD1QBZC08hsdtFabtKPBYJL9d+NKQ5A8m0jCusSSs3XMcoOr0zPACCbjpLv
         YAiA==
X-Forwarded-Encrypted: i=1; AJvYcCXmrZFuSjmKAYK44JflwXaRJ1/63OuW5X3kf0VPd0votfcORHVqZJIqjZuCrVHuI8N0HPO6NOMrqWTaBmCiP/zpQnkmZ0U=
X-Gm-Message-State: AOJu0YzE1UV6Slvc9a2H0lWR6RyBam1AgV6IroSnL6LpdDi0uhtr+AA6
	8k/S2m9GpPpQ3Q5FwnPQWzXyGm9MJNTqx9waHi95GVojAwqLsOtt
X-Google-Smtp-Source: AGHT+IF+t7gw8NE+exX25J9xmMHiGEAVUDpnCrOPPo3C43LfOiXPYaT5RiT7mlS6la0torbVT1N9aQ==
X-Received: by 2002:a19:9156:0:b0:511:4db5:99f1 with SMTP id y22-20020a199156000000b005114db599f1mr755657lfj.47.1707864419657;
        Tue, 13 Feb 2024 14:46:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+e+fpkE815s9YIEA4ppg+yaXx9HNg50ERt4ElOzJM1iQaKScgv6MJ9HUkqGtwm6QItAwyMbo5ELU+a9HCBFTvvNHIbMP1wVJEd9v705O+CvCJYMxWGQhIOTNsd+dI3AiktYBn41MuBdafW9HH4fZ4jUIzJ8wiX4nqZnAhaWSX9zfBVOvnt4y++nIFPe7iTyqYSm9l6XgAsg08mR0/9d/dycahBM5bwBZfob3GH5XpiUFwMfzh9BXnMvG8eoq7Ufdebtmp
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:59 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:53 +0100
Subject: [PATCH v3 4/4] selftests: damon: add access_memory to .gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-4-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=832;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=LxI8B8lBhn/XmQtHholcJbNICjxQ6qBn1CW3zMr7+G4=;
 b=b7oBHxTOzmxfTZ1mX8GnG3XuE9dnjr4kvcQ+VOcn/NbxWJt/LzL4uKo/vxUr/7ZICxhNHHgQe
 +PYxh4pJgPnCxOx7m1r8V2bnkLY2hhDn9vUWZii4Q5cWq8kPyoEijtd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This binary is missing in the .gitignore and stays as an untracked file.

Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Closes: https://lore.kernel.org/all/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM/
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index d861701f0327..e65ef9d9cedc 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -2,3 +2,4 @@
 huge_count_read_write
 debugfs_target_ids_read_before_terminate_race
 debugfs_target_ids_pid_leak
+access_memory

-- 
2.40.1

