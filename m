Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE221D5B0;
	Tue, 29 Sep 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668897; cv=none; b=fMCpK7iIdh0Pg7OVB0VIo/efdDQMz/bPchHRHD2HpHFykttHj4p3mFzUKFdFu+Lz6xEoaY0ddqpp5G8SCRFRn+APAEWrm04WxmB8m3dqSHODyv2GBII0y/XseEyUX2MsLnNKeiNiMNuqXKg9k9jeVMSZPn3Jdmi9z2n38FETMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668897; c=relaxed/simple;
	bh=vuSmGx+d+J/LvI88LPH30k0DyNekzcAX8xyBFZF+tx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1TYXx+EWwSsV0RnhlpBozdWJ1TFLkWECwAV6rz5siYwGHw5VPLIkShDmWvNBwveBmPGQQvF8qInx3W/BvLYzyjO+jmpocdBUx57s+HbpX59ZmatjyC4E/tNO1j/JcYwzoQZeplP7/Bm2glqG1e+HXHtoSO1U0azeuy5NecXyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEQpeDY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEQpeDY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F141F00898;
	Tue, 29 Sep 2026 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668894;
	bh=s7JRcQFcD/nLSCcRzyB24nV92nZBWi01kt7jJ+1f3Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEQpeDY7pkyQiP/6fqcHuonHtC5l+T825vbXq+6peAhJ1F8PsNKBBLsfRCYUJKbq9
	 4Q+n30FxmVECVj78BGGaXBSLoPXIDIZfTNpewh6WzYxkgHFDJmmO1NOJ+lBzBOwWDc
	 P3D50PEuLe4ARXi+/7JEguq/QKEa6RCEdw2BemFyX8wNNyQJ9dluNndnGsmwoTaDnQ
	 5U1PlM7s4Zv4XMnTlCe35g+9pk0JGQtfaL20Z1IA5vwzocESHgvGDlRLSCpLdk/7cQ
	 G1HKP2YpX0536rujpVZKpvvnneYDydJougi9nGrWUZdXlsCu/Fus/qPHg2Wymj+JRZ
	 lRW51B86EcLdQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] Docs/mm/damon/design: document damos quota goal complement flag
Date: Tue, 29 Sep 2026 01:01:09 -0700
Message-ID: <20260929080113.41708-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added damos quota goal metric
value complement flag.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e82390e77a70..5cd651b1b7aa 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -702,10 +702,10 @@ There are two such tuning algorithms that users can select as they need.
   that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
   <damon_design_damos_stat>` will keep increasing in this case.
 
-The goal can be specified with five parameters, namely ``target_metric``,
-``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
-mechanism tries to make ``current_value`` of ``target_metric`` be same to
-``target_value``.
+The goal can be specified with six parameters, namely ``target_metric``,
+``complement``, ``target_value``, ``current_value``, ``nid`` and ``path``.  The
+auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
+``target_metric`` be same to ``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
   has interest in for the value.  Use space main workload's latency or
@@ -733,6 +733,13 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
 - ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
   (1/10,000).
 
+``complement`` is a boolean parameter that determines whether to use
+complemented value of the target metric.  For example, if ``complement`` is set
+and target metric is ``active_mem_bp``, it is effectively same to
+``inactive_mem_bp``.  ``complement`` is no-op when the target metric type is
+``user_input``.  For the metric type, the user should be able to emit
+complemented metric values on their own.
+
 ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
 ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
 point the specific NUMA node.
-- 
2.47.3
