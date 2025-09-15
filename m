Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACA2405EB;
	Mon, 15 Sep 2025 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901499; cv=none; b=KRFC/5iNwcQZoFg2MBBCaKvNqroyuLI5wcQXwngvnv6TQxm7rDkL4vRgCGPQ7lD2qH4vzXvzrrtotJxiayQfuC4chrWytLPLT/6ic4Efd1N/Sq0Iz7Bi5HWMIlEtul5MsHSdpFXne+nhT//ZFbIfOBm6bwUYdONZcKoG7fRTyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901499; c=relaxed/simple;
	bh=DAVCpI32krZKX7tAL5BJ72tG+a8Y+Yz9N/KNa3xRsxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvrLfDThkV2EGhJNOjk1/NLj4MsuIfD1w8sCzik0IUukduGUT4CMTYY7I0xlwyW7boGi+Tw6eRMt0a/FfyzWTY1UTqv8RCa0O8EWLOVHbaR3cFnaBC9BVrvR0aJTw4VJ9xEoJ53jSX4GA6U+tgk0E9B5BgvRouSQXYYjAWmFzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5MLt3OX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5MLt3OX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4D1C4CEF0;
	Mon, 15 Sep 2025 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901497;
	bh=DAVCpI32krZKX7tAL5BJ72tG+a8Y+Yz9N/KNa3xRsxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5MLt3OXROpxw7J/b2AaPOt6R/868NrvNrr1mvdCZr7cI5wc6vhu0FGpNglEiz3f9
	 xTYFFjKsXM6lKnhvnnl1Pw5AA/4ExAJ0pEPn8E0oKcW/eTRFr4y/pGWMDtx2vSP02t
	 B/KhoKiWrPb2qtEYa1vX23oRqcBUEKMFPyQ9D4d56J6s31Sy9aGvCx0XJ9IrTByv0X
	 mc1KNcJ8ho6ByaGYL+J33n6qqth7KPs0VNSGTStEHeIs0NrXiyHPE64sf//xtzAb9F
	 n1ESaGXEsqVz+McdvMeZ4yXeqrY80RxDM37WhgogzrzgD/bi+6oSE/ar49zJ754zzB
	 wLOwGmZDi4+WA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example command
Date: Sun, 14 Sep 2025 18:58:06 -0700
Message-Id: <20250915015807.101505-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: <20250915015807.101505-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example command doesn't work [1] on the latest DAMON user-space
tool, since --damos_action option is updated to receive multiple
arguments, and hence cannot know if the final argument is for deductible
monitoring target or an argument for --damos_action option.  Add
--target_pid option to let damo understand it is for target pid.

[1] https://github.com/damonitor/damo/pull/32

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index ede14b679d02..ec8c34b2d32f 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -175,4 +175,4 @@ Below command makes every memory region of size >=4K that has not accessed for
 
     $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
                       --damos_age 60s max --damos_action pageout \
-                      <pid of your workload>
+                      --target_pid <pid of your workload>
-- 
2.39.5
