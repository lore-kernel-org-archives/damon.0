Received: from outbound.st.icloud.com (p-east2-cluster2-host1-snip4-10.eps.apple.com [57.103.78.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1A4502F
	for <damon@lists.linux.dev>; Sun, 17 May 2026 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003305; cv=none; b=hQFdU9swdz+v4lXxC38XmlcpneLNmgqyg+6nYbUUaZq+jrC3dbRRZGC6PjRTkfinhqQHF9N6PtBxJ1mOxUCgrO9mJa4+/3ApZTACEB4DGidjZqI7+qMxVmPpjE6SUnrhMdT93Zmt61gQGJy2cVtjmDGN1TO/pe9vXxs5m2jL9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003305; c=relaxed/simple;
	bh=QtHMk6BEzWZrpTUCQwXKVSHqPCVL7aj+to4MhpXuRFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rk8Sn7dqBJTY+81hm55JlgeLccHCXme7VgO66dCf84dLRHwtXBkVRgnrMrsurQJ5C4M0Mw1apUlOsOUM2pisO88dQ/geZxHKNnV4sdIVEMq6xAe6DrHAQloIqMfB/wYUe5/EvHZ5AMlgiztQeDlap/d2v5ho3wXksJHo/tN61I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=G7vjuzU/; arc=none smtp.client-ip=57.103.78.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="G7vjuzU/"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id 4709618000CF;
	Sun, 17 May 2026 07:35:01 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEC0AFBlgARnkRUAFYHlZeWhdeTVEPDwNKEAJeBV1yGVoUXBhTRVEfVFhBDgpaBFBRHV8CCgRHBFsXRgNTRUEEFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDxlaFFwYU0VRH1RYXgRTVg5CCUoFXQJaBUAOSwdeBEUBQAhNHlwaGEEYCEsBW3cCURxWDVdDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1779003302; x=1781595302; bh=KZvJZ6sA8BqOCSFmfh6e6tNl4NE226dSLmvr6UFm2Fs=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=G7vjuzU/6HgOQQbCiaECZ8pNmlTN7KCrEhYqEDWRlK0Ot63PM2g+8ygdPBS7NH0K8CdBAgH1AJ0uCw6ys9Xk3qPvZn9O1Yi/IDYx4mJf8w+IncikiKMJ28/uoRPvmrP8sHRIZojpzuO1uymIW3/YAQmj+U+gbnMbCJCin29pjG3VQtNYWd0oFQ/9dGg3fMTaycOJTJQDzNRPk0E83TrcQAvoBtVR5xQMQEe6d3M3zsFAHswvQ5miKjXSkN7iRu2G9/cQp/H7Fp17GTkFT2MNfpFmzOCRXJKshS7CNWWxqrSYrlKSw+Bja8NGcTcr67psiw5M0CKZYi3UYRNcpATaUw==
mail-alias-created-date: 1778972301885
Received: from localhost.localdomain (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id 428301800302;
	Sun, 17 May 2026 07:34:57 +0000 (UTC)
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
Subject: [PATCH v2 RESEND] design: fix typos in design.rst
Date: Sun, 17 May 2026 16:34:26 +0900
Message-ID: <20260517073433.3015-1-ssh1326@icloud.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gu3jiF3L1FKapOQU1W16M9Hnzjx67DJx
X-Proofpoint-GUID: Gu3jiF3L1FKapOQU1W16M9Hnzjx67DJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDA3OCBTYWx0ZWRfX5a2mqMHFYyPe
 JbrDuHWXfmYopx6ty+qt2kqc0lvIlqxSjkZWfcAXImEmj6aPHQvEDfHTyCRtlMrPfcmXnlea8z8
 HXmoi80TEs/9nLOYAL0U4DPXU9zQsg9bkmzK9s00OlBkRIPfc6QT7+kGRcttv/LWUgPHfXQERQP
 qY78tEuS2fk5I+KXGozOM7zzo4iN+mYbdk1d/kOq5GUW8Jy8gwjGmh4bJP4sJDtS+b4P4dGFOg0
 tKrfqng0qAwrpfXyO8dYQp+jjxt/eFP18EptuuDMXVP1HO5+WuBItdxt71BMjIo+t+eTCTA196I
 ygawgfNXbvEc5NyWjEEctDFGG28eyYAcaCAzeYGsojHvpKISvHoj1sg9Vxz5xM=
X-Authority-Info-Out: v=2.4 cv=Wtgm8Nfv c=1 sm=1 tr=0 ts=6a096fa5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=ZxuoajvSgW0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=_08Xcmskz7rbIMj_RqsA:9 a=IxSG75etxsVYPPdR13TJ:22 a=lOdrInXjANxufYs0I0OZ:22
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

