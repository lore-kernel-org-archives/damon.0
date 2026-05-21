Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A5409603;
	Thu, 21 May 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374083; cv=none; b=ewGyETT4tb0Tig0VW7LTWEwdbwJSGcnQy2qk/10B9jdQlJZezNxMUn7oJ/jLQqCQocTh0suuGLOjwsFPNbUoDGYw8D7O57VhIg851ckwGlM4YHqvQXiliP65+9PV0Fd50ZlRqTFY0mZbPUGUMEpGyhm6PKMpnYURw2AZIkp3CIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374083; c=relaxed/simple;
	bh=ws0D8iuldfRLR1MHNkuGGInMFKktNMpgiEm6ektZ6B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbyrEg+SLJ6JHqFr7WeWnznonI0sibh4r4RBIiCcf6M68kN69RViyVhx5fhDcF/bS8BgfvzOr9BXZZDwECQUrL3tiv/MyQzyNn2I8Y3Fb46ey5VZHuhtKHyf/xlVkJ055DV/2ZYtivhANhwp61u0hkkspz1UNkvKvewDvkAWDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK9JnRGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK9JnRGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5671F0155A;
	Thu, 21 May 2026 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374082;
	bh=jOZYn/0HiUYme65VRURmz3VNOCuqOPU+0+8yZhbpho8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IK9JnRGcTK2zdvVbFZfaf1hH0Y/rwP6hR3UsV11SYLL8Eeadueby+++WOFS9Rmdrp
	 hFdSwop/qaVXAN1wzBy3PURsmJOa7AUArEWVzUSvhgFo4vs6rPqLZFIsGoIutpv10h
	 o7krfODDUU4idkN14D72zcDVIC/aKKad59jVFDDMrl+qa6euJ8Qc3kmHkU3lUB0FwX
	 H/NP1OhsMBe0CjzFnaVeUqQyrYAV0QTCDLGb1OppaLVA1Ic5PLLoQfTVSc0yRWDJno
	 iceoP2mrfha1O87pe48OZmwlDA/tLfqs0DANQOVUUKrCy4Gu4YgLPVrQdYuxe5C1v7
	 xR+jIMpf7pmwg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 13/14] selftests/damon/sysfs.sh: test addr_unit file existence
Date: Thu, 21 May 2026 07:34:23 -0700
Message-ID: <20260521143428.83157-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing the existence of addr_unit sysfs
file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index b3418214ed358..92b44c86818af 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -365,6 +365,7 @@ test_context()
 	ensure_dir "$context_dir" "exist"
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
+	ensure_file "$context_dir/addr_unit" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
