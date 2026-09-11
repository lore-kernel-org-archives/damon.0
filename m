Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84132779D;
	Fri, 11 Sep 2026 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089232; cv=none; b=T2iGCJw3xtXC4ZEAxhU4pTqBNOVMPWPMgv7Krt02kAT1TakXBtOL/qVN1XmZ2I83yvK1Bz/0/dx2eV1GcsbPNNwvgUDNAsugwBN1/zVCr0ussJq2WRbiccbssAG1OLbaIlwQhHTzQmWwA6ResnGAwQ7hW7bzDrPql/y3BVbktX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089232; c=relaxed/simple;
	bh=TxCcrhH+EcWCqlcOItsNzCvegydeKP2OAcmuPJWEIBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mumc4KC5wiS/2fDFh65qpSNfmQVKK25H9bVCTR2xOrkxvIfIFHZwhBNzj2lbsbSNcRQ0xGRr8G/WH6yI4TmjUXij6cQMzPA9XCEQMWhpKwgYPoJZRBRyRGV4m7sEzIGb2USiX0aLsdGmiEgCXQh/1+hAJF/QKtOqPm60wcuCmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By+QnNE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By+QnNE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79BD1F0089C;
	Fri, 11 Sep 2026 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089219;
	bh=6W4HqJKZTtS8lrUgM9flAHj2CUZu3m4em5eZnB2Nzv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=By+QnNE9go4mKfn7GmKuFDIM9o92tXdwMct7p5PUR31gHqyTNHzSgJ6XCR4PJ5W8p
	 SlRsQXFWMBLcEFckzTmevCUw9InR7EbgC0zUq7P0YGC/UWswIc0K7peOKwYUkrriHW
	 Rw06moqhyRMDxAOJH8V7p5XY8WEwPCEjUfzgTW99X3bEJL6fiK9+cD2FbG28RPUdrx
	 K3n4fVxOFvx6q1cLrSoyv+rWVx6bjTSviV7nLAnc0lhT+Ruwl5CxuZIMVEHjChzmS6
	 6c3US9IKBa9pWquwSHj/mK6C4HLxQhQjBnNK8vID6mJx8LFtofnPbnakx8HqkVaLf+
	 6AxsIp2pA6P0g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Thu, 10 Sep 2026 18:13:26 -0700
Message-ID: <20260911011330.93678-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911011330.93678-1-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support probe_hits_wsum input.  Also
update sysfs input based scheme build logic to setup the min/max probe
hits weighted sum range as user provided.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 4d9147d2a269e..3de4d804e049f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -589,7 +589,10 @@ damos_sysfs_filter_type_names[] = {
 		.type = DAMOS_FILTER_TYPE_TARGET,
 		.name = "target",
 	},
-
+	{
+		.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+		.name = "probe_hits_wsum",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2844,6 +2847,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
+		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
+			filter->range_min = sysfs_filter->range_min;
+			filter->range_max = sysfs_filter->range_max;
+			if (filter->range_min > filter->range_max) {
+				damos_destroy_filter(filter);
+				return -EINVAL;
+			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
