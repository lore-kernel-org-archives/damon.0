Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB6409DFD;
	Thu, 21 May 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374084; cv=none; b=h6iiZ9BRFAlfV9hwy3vDYukKNFRPYSwzOiYpw3JsssHt48dQnBqKnkI7eDbkqHtbO2la0CgQA15cMh3/K+JNXj059q3X5fb8Ib2AdsEVus0Y1K704nPKFMzki5zSX19EE8xCf/i7RdL0nHfdZNxfu1tn63RUhVoi4oQ2fYdNY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374084; c=relaxed/simple;
	bh=vlSxJq/mZG/PC7FG4BVhxJBrns4C2X+9/1QoBF2tbHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW2IpY8KN64wyUU3xwRzcn8KB69zKm4nOWVpCeA7wDJi3zKjfHREi6MvNyEmSBW+Zp3WVrn9fOxac4p1ckWsWWwl9vYWN8ZxCdYZOHmW285jlwBCDuxq7u08ldQ1/2IgCd11MjghMtJk0dkykUCeFkTa1pZxSbbx1zp4s9vEFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbr7hz7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbr7hz7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F651F000E9;
	Thu, 21 May 2026 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374082;
	bh=9Q+fxjZuCnosHblIbwlECkpSubPFTTaxfUpkwZ9ZxQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mbr7hz7YcemYHIxCvxgFidxLPabBO8v8iCe2Dre4oypmwg0kxT1enQSSazfXttV+8
	 kH291s3wRJ/bUNnbBxFDOgs5/VqudtNmebjbmVGul6KwPy0MFk4wSHIlrzkcwkJU4j
	 hQuGQZOihSsTDTCx/PLg2TR/X25Iu3R8EQs+SMmPO43r1yKs3bKrXyVxyyMnczfKfc
	 MEjJftNjgf0el7HBkoLOsyrwLb1nSPYJExJYuqGqEgfD5KQkxdeE/FyBlqZrIo1Y69
	 AUVD/EYmd26qTTVQQwD2ME1FipFvS+ogR6EKmXCNRuvC26jsEryDCOqW1OIwfq7HYQ
	 ArXeLXg9YDuTw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 14/14] selftests/damon/sysfs.sh: test pause file existence
Date: Thu, 21 May 2026 07:34:24 -0700
Message-ID: <20260521143428.83157-15-sj@kernel.org>
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

sysfs.sh DAMON selftest is not testing the existence of the 'pause'
sysfs file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 92b44c86818af..78f4badb5bebb 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -366,6 +366,7 @@ test_context()
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
 	ensure_file "$context_dir/addr_unit" "exist" 600
+	ensure_file "$context_dir/pause" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
