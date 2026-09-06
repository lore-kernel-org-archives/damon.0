Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D603101B6;
	Sun,  6 Sep 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717020; cv=none; b=d+F2yOI785De01iFpb+kiKbM9uttj3Wx4t/mFfVqfVXFR5jcCvHUz8t/JWGetwac7e8ztSrK9nTYaYqnU0CEYdO2b5jAmxJVfY6ixwt0+RytwjsDuo+otT6H40p4Xhrpf2K0g0trTeDmp0JaOimMmg1UXH3Pd8ktKTzEba6SAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717020; c=relaxed/simple;
	bh=yCxGfqVWzlMnnWV88b3PWYG2+zaRYg5Y3mxtSqQe6og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6jMRXcrDyv66seANpmB6Us1pzdEuJsPxzIgb4ktqSIKB8efzbJKlc2+8mL/UEogL8HOBi/1Al0yXrpKY6nTMwEGUYaxP8ZQL/0xHO7Htr3xX+Ox5hRiR9jJ+gZ0arMPve0xXd0Vq0aPkq9qIV/yEgyVZOQVaQbQmCySvRzSsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJvljSHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJvljSHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED81F00A3F;
	Sun,  6 Sep 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717018;
	bh=nO6vnuxi6J2KrNlifTLU/7q+ZvNIHG45rulFRzj97d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJvljSHw8101nwn1KyGpg27PWjkZXnR/Yeb7FxtPCgJ88B1jNoX4zs34vr1eGu53/
	 bjhkjc+JDQuHyKScBjQoQ4RnmMxlaGsrASnJ+HNwsU4qF/5p2H2H8B5k+R2qM9EqzD
	 9Qc6n58PH935cd9jISrtcW6kGCLt3VYrNq8nbbQc6OBsRnAquOFb5nSGDmNNvseP7U
	 r2XXsL6a9IelMAo5QvrBkcQeJ1/ubw1DmSpQNNwF7tSrFHvthCA6FXdgdIVHObRhs/
	 xkXBjOylJSdkBtSKWLYxjO9KJevPobziew6UR6WxYfXFajnHC0MA2i7gSLFCLJtTzF
	 3h2Vym9oFP5MA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH 5/5] Docs/mm/damon/design: update for pgidle_set probe filter
Date: Sun,  6 Sep 2026 10:50:07 -0700
Message-ID: <20260906175009.93471-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906175009.93471-1-sj@kernel.org>
References: <20260906175009.93471-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added pgidle_set probe filter
type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aac84de261aa8..22b785cd11dfe 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -299,6 +299,7 @@ filter types.  Currently below filter types are supported.
 - ``memcg``: Same to that for DAMOS filters.
 - ``pgidle_unset``: Matches if the page for the memory is marked as not
   access-idle.
+- ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -314,7 +315,7 @@ actions are registered, DAMON applies the actions to each region's sampling
 memory before starting the next sampling interval.  Currently only one action,
 ``set_pgidle`` is supported.  The action marks the page for the probing target
 memory as access-idle.  This can be useful to be used together with
-``pgidle_unset`` probe filter.
+``pgidle_unset`` or ``pgidle_set`` probe filter.
 
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
-- 
2.47.3
