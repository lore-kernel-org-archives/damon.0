Received: from outbound.st.icloud.com (p-east2-cluster5-host6-snip4-5.eps.apple.com [57.103.79.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F091AA797
	for <damon@lists.linux.dev>; Sun, 17 May 2026 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979752; cv=none; b=FDcEKBee3eWWg/hMjvLmLJc63+kx/n0voh7yT281fd7PonBTwu3MjzZq4IR0LJZbtM78Vf50IqEzS+gJekFxB3oGlbhth2jziQPw1VFqSULN1CkD7q3IgEL3Vw4EJTEMtH5Y9u7bmjosz6I5chrEUuVWyQigsHfoh1kj3CaljRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979752; c=relaxed/simple;
	bh=QtHMk6BEzWZrpTUCQwXKVSHqPCVL7aj+to4MhpXuRFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZG+Aeb2wD13RUvwzN9lxskWt58f9TelGznyt6lRNVn8qh+JMpUUJ/ToicKMsxfMxKPK6S1KjFfbhh+zGS04vqItLZEDpqzCUBPc1KJM9TTXdN+g+kWfYhGWwtaBx3gmLcOWLF0Syc6+0M4YXXpRNO17TGIW+QOXN+0VKaNyXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Bgdpwqtn; arc=none smtp.client-ip=57.103.79.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Bgdpwqtn"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id AFB2D18000A8;
	Sun, 17 May 2026 01:02:26 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEC0AFBlgARnkRUAFYHlZeWhdeTVEPDwNKEAJeBV1yGVoUXBhTRVEfVFhBDgpaBFBRHV8CCgRHBFsXRgNTRUEEFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDxlaFFwYU0VRH1RYXgRTVg5CCUoFXQJaBUAISAFdBUUDRAtKCkAGRkEDUUkAXwErWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778979750; x=1781571750; bh=KZvJZ6sA8BqOCSFmfh6e6tNl4NE226dSLmvr6UFm2Fs=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=BgdpwqtnKYIDnhy/U6B5W2QGX4O4En3K+2N/ptpstJ9QR2KL20o4zhKCEcHDDOWeNmfzc1jcUUQbksdWNDcctuBhc/1oC9gaZO6HnrfleWNSPC08au8jg2c0RAznwSHFu8nWNzsJl23jD01Cb8tfWDQ8IaPalCMICe714P3SLAlatNWJ/a3bpNxQCwsS7O7k+FgK07S/lq0+XzRFiMcerlWSjMeN3LtiQQvg1XzVOY0/ZH6H4S2PfsbSXxkzcBufJ+hyJZhzzAB4+Q6CQ+37wCeD+MjZs3ExbdNczo45LOtBDEufv5g6/hSJDxtViHPQuspfG0Imyu3zTlMnls1b/g==
mail-alias-created-date: 1778972301885
Received: from localhost.localdomain (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 698EF1800146;
	Sun, 17 May 2026 01:02:22 +0000 (UTC)
From: Sakurai Shun <ssh1326@icloud.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Sakurai Shun <ssh1326@icloud.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: fix typos in design.rst
Date: Sun, 17 May 2026 10:02:00 +0900
Message-ID: <20260517010202.14229-1-ssh1326@icloud.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516170847.146524-1-sj@kernel.org>
References: <20260516170847.146524-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RzyQ07uK6sRGQGqmE1AXpUZWNipFyCnm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDAwOCBTYWx0ZWRfXzqH9oquXREoN
 b6SLt0Bu5KTSDylCqPBHENuyxbEeAOCmvboxbMvwF7N6gDbdYKLlWZ5l9R4U8eos9mr3silBiN7
 Ctt5ZQyeAOCqQOvgVGp11q/UAUbGI7liXXE8W/gKDmONyUEvtQvg2aF5Rtrr0GQS0JmNaKqwV5e
 tBtKH7GyHe3l6ZKMc2F6qARVnJJQkIGMIa7Emp6AFiukuTp44l1glfMpNCVg5/KJEctveAeFlBW
 16POtcNZ3VTX7e5UDz5cppqobq7lVii58G8E+NoC++z8U303YZtkrlssVyG1xyRub9sngD1e5FE
 D7RTMP7gRHA6vAwzMW+fOyDIKCe9HwIHjr7UnarWhfu2euM0wibFvHRY7dmimY=
X-Authority-Info-Out: v=2.4 cv=FssIPmrq c=1 sm=1 tr=0 ts=6a0913a4
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=ZxuoajvSgW0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=_08Xcmskz7rbIMj_RqsA:9 a=IxSG75etxsVYPPdR13TJ:22 a=STymlzgejnUetJ8yQWeq:22
X-Proofpoint-ORIG-GUID: RzyQ07uK6sRGQGqmE1AXpUZWNipFyCnm
X-Apple-Category-Label: MjE0Nzk4NjU5NzY6JGNhdGVnb3J5JF9QZXJzb25hbCw=

L140: "unsinged" -> "unsigned"
L371: "sampleing" -> "sampling"
L387: "multipled" -> "multiplied"

Signed-off-by: Sakurai Shun <ssh1326@icloud.com>
---
 Documentation/mm/damon/design.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bd..9cc70a296 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -140,7 +140,7 @@ as Idle page tracking does.
 Address Unit
 ------------
 
-DAMON core layer uses ``unsinged long`` type for monitoring target address
+DAMON core layer uses ``unsigned long`` type for monitoring target address
 ranges.  In some cases, the address space for a given operations set could be
 too large to be handled with the type.  ARM (32-bit) with large physical
 address extension is an example.  For such cases, a per-operations set
@@ -371,7 +371,7 @@ with theoretical maximum ``nr_accesses``, which can be calculated as
 ``aggregation interval / sampling interval``.
 
 The mechanism calculates the ratio of access events for ``aggrs`` aggregations,
-and increases or decrease the ``sampleing interval`` and ``aggregation
+and increases or decrease the ``sampling interval`` and ``aggregation
 interval`` in same ratio, if the observed access ratio is lower or higher than
 the target, respectively.  The ratio of the intervals change is decided in
 proportion to the distance between current samples ratio and the target ratio.
@@ -387,7 +387,7 @@ The tuning is turned off by default, and need to be set explicitly by the user.
 As a rule of thumbs and the Parreto principle, 4% access samples ratio target
 is recommended.  Note that Parreto principle (80/20 rule) has applied twice.
 That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
-to capture 64% (80% multipled by 80%) real access events (outcomes).
+to capture 64% (80% multiplied by 80%) real access events (outcomes).
 
 To know how user-space can use this feature via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`intervals_goal
-- 
2.54.0

