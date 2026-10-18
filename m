Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC6175A95
	for <damon@lists.linux.dev>; Sun, 18 Oct 2026 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289070; cv=none; b=EJSEHac8LBnz1Gae0cw2JV8lhi29JmZSa6PhvoDJO4VX8PrOhDCX0vn79oXV5SUsr94gnL5XTCQkiX/jDZT9Td1mpaHf7qIXIzeyEtb2q8GiWd0AK+S+/LqELhUd4Q48osLSRjzkq0EB7CXJOww3OQ3NuJUmCEDwo+Ic5CTIa/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289070; c=relaxed/simple;
	bh=caZTDHt6UILp09QROvQ0YGeBMVOn9q8m9mcI8/xIScg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCie4OBUVhdVXZRHorkf8MHruqmd9SiYoV9we4OVMBWXG7hUZKe2ULsQiaJnFds+520+zBTt0/VA6O7bzAc45SwkRDM7fI60/wGQXKpb9q5+qJ8bVTYaR/lXhl4BAmSDxC/hRJSV7vVCHxy2b4s1DGOsYFhrE6P8VOyKrwuCgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qr+74oKN; arc=none smtp.client-ip=74.125.225.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr+74oKN"
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48c50db3556so513569f8f.1
        for <damon@lists.linux.dev>; Sat, 17 Oct 2026 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289068; x=1792893868; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcLGhS41qDyrPASVGx39Zak2pOFp3aGzMbLkGewPdag=;
        b=qr+74oKNO3Vj9xUvIsZrwjhKGPnYRXcyjPimpsG6fbdaI54kIItQL732tv2eAGrbGJ
         3I95q4jJjSeXHs6FIYYaivKRURlcNlhvxGRS8KBVKGNy0Rr7VCABhfHUoPeJJGK/sYF7
         IRBVLye99IKibL1cOjS4awnwL4/90sAWA8k4KyIRBxxptqJxxn1AN34UDfozQc/RpSzq
         TRNMDFehhXM7fkiYaG/PYl/sKDfspdVb9nBVy/vkd4jqO482vjTPkOsuxHiYSVHF/fIM
         SKVf/A5OeiHg5NRAWtNEdK/05g8uae5GR3kmWKCtR7+JpLo1KgB1N2DIA3OtskDFau2z
         EsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289068; x=1792893868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcLGhS41qDyrPASVGx39Zak2pOFp3aGzMbLkGewPdag=;
        b=Px8boZ0FEabwJ3XIt/N44N9H1/UVUFHQCutuLCIdTzwxiiuxmazAd5da18Mx1nyh/l
         EvzyH26BPA+M56f1nwyPa06nGVKtdpXMz+ihHx/l+1DUMmUEddLxtUREUMxEjuB/gaoy
         9PXac3Y/hWFRYdpc8lgmWeBVDNwqO3N45gjlWJ/lEo4ZgFOXqA/+m9rDeXJmOHBnH6If
         hAVDwZRi6F5rFKbKtL/3MPIlGTY1XptTmVCn9k50KZ912ccV00RNYSbFhJi5vp7kXHKs
         qyhkYbl84m+fkz21jhV9DSTLuFWKJ/0DsibA0qH4vTe77VeNndcHUdAFCGZ6qLrP1+jE
         OyCg==
X-Gm-Message-State: AFq9FYKNfFPg1n2VUtUS47HQbxMxb+z7pGeiL1cdN8uUPR6d5zv//V8s
	zpjK1RzIt79T4Y4dMGN49igZLY50TxM3n6wB3pYkMsUs6GuWL2lj2Luq
X-Gm-Gg: AYBFou1yIBoX5Zztey89jzcnZlknL/Q4seEG0hqIegqSaqqg4jw9H6b5H0wxEwLPApo
	wNfU1y5S/JcqR32KOmVggBMk4e5fWOOQj+kg6UXC6wJ/FjC3G31GcIlZ5AIGQtxtmrJEH95xtJl
	CzJAlOd8GoyoV2JRg8jIQQGwXVVtGEZzuZEUoazfAOTaIRs9Nw1JEjn2z+Q03WtOrkJaPoug/Go
	V3RaM38yQMnYkcMwM/NqeB7+sx3/xUk344A77ryFDmRyunDTeHj6Ep2ndNPWTe2SQa7whDvGT2n
	SOVuG3yRTxB39XkyX/hHH7HM31i+y5abfyVHALcyGqoz770uOBlxPgdkIpqiEezlD1AvOQ5NOch
	2xq873n8YxYHjOotGsUAVRFIy1xTs8n/zrojB0XO1ngGJG6OW0PtS19haY+kb1upFil3nt2W5t8
	z+Ju8pq88oih2GvyugFeBJk6BAyx5RRwhXDFjhuzbsPZaMKubHET6ZGy7aVn/Cmvqm8y9VEOQFo
	+H31Eh8lPlGcTwdgC0JZCWK1nsSXS3u3dq1/ujyP0Etlvck4UxOALstsxGsVYECTzYV5HxttFzW
	pZz7cwvs2+QJMPIusadvQLPcS98F2W0m/w==
X-Received: by 2002:a05:6000:4381:b0:48c:6955:a603 with SMTP id ffacd0b85a97d-48e07bb5a24mr8947014f8f.13.1792289067693;
        Sat, 17 Oct 2026 19:04:27 -0700 (PDT)
Received: from lima-kernel.telekom.ip (84-115-220-212.cable.dynamic.surfer.at. [84.115.220.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4e7ff1sm15001449f8f.25.2026.10.17.19.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:04:26 -0700 (PDT)
From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
To: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/damon/sysfs.py: stop obsolete_target shells hanging the test
Date: Sun, 18 Oct 2026 04:04:15 +0200
Message-ID: <20261018020415.35567-1-jaeyeon.lee.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The obsolete_target test spawns three 'sh' processes as monitoring
targets.  The processes inherit stdin from the test.  When the test is
run via 'make run_tests' from an interactive terminal, the kselftest
runner executes it under 'timeout', which puts it in a background
process group.  The 'sh' processes then try to read the terminal, so
the kernel sends SIGTTIN to the whole process group.  This stops the
'sh' processes, and also the child the test has just forked to spawn
the next 'sh', before it can run 'sh'.  The test then waits on that
child forever, until the kselftest runner kills it after 45 seconds.
The test passes when run directly.

Fix this by passing stdin=subprocess.PIPE when spawning the processes.
The processes then read from a pipe that never receives input, so they
stay alive and idle as the test expects.

Assisted-by: LLM
Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
---
 tools/testing/selftests/damon/sysfs.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 66c826189320..ce54fa21c09f 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -390,12 +390,12 @@ def main():
     kdamonds.stop()
 
     # test obsolete_target.
-    proc1 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE)
-    proc2 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE)
-    proc3 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE)
+    proc1 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    proc2 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    proc3 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
                 contexts=[_damon_sysfs.DamonCtx(
-- 
2.43.0

