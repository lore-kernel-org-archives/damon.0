Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727191;
	b=jwdv9/MmamU6vDK6+YD0t995ebMDTqAVf2Y3RxjR2sbZlUrhQC2xN9V85kQpqXz3l0TL
	 Qm+97PCQ0+PB1Kh4exJj1v6VwD/fyUXQQAWTtD8RpRae6rGQwpNmpSRHyLYOLfO3ZbKst
	 bFrfRHdWSa5x/KA8iuiEnUDs8TRBenx7Urv7ysSKsaToJncMB1R91UY74f5RZ/ND2f0PK
	 tUSL3XHMAIMUSLSrvKuj8U3H/EQUVx9RRMHLaK5YJW2t/uulGIy8RP+aHauHiijx/1Iyt
	 fpkCMYWmZ0/2aIEcn0DrgCL2OD2gsXwgARlEwmW39T9hVStlz7tYPWkrlqx0tM038EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SeTTtc4pH5Qdy0QRbAyn5ThNALUromTyBmx5tzYSbKo=;
	b=oH/puhVVHKqG3Tf+2LS6CF+7js2CrJdHu3ANBRrL6v+00iWHeOq1zgcFzRzlV7J7/W3U
	 EwV8Uou8NGHQPNL9BRCFr+OwG2j4lUPrLKWujrca+/hKZRoR9X2VZnrCq7geqbB58h0Yh
	 FtteWk8pjrn3y8vqjmXvLwvd/85LWF7mTPv/SzFl9OlPLz01JQEo5AHjcq8sfd4zy3q9W
	 p7YWt8T3F2ckUInPt2OKscu42qxXu+gj3F90AFIBC6TpeQ39pwNJx0RUyntiGGtBkjnUm
	 LLAM80B73bipl1QwU3h1kjMY7daYonWeCA2Z1lORL8RJWyk1Qq6UHn5zzOf26wFJBXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaaQyMD7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4561606A323
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaaQyMD7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5642E1F00893;
	Thu, 26 Nov 2026 21:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727190;
	bh=SeTTtc4pH5Qdy0QRbAyn5ThNALUromTyBmx5tzYSbKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YaaQyMD7sqi3aLwXqaivPPbuFvT811e3n/QKn26RVL7ixe4a5gMPo7IEnmylZJ/ND
	 h+KCkjFmUSbxyjV8GzBbad1y8PFrnGhy1xpnl7tKRhfxtqwVuxdaobiBmRveQxpC6G
	 b5UV9b5hUFOIxP8yaJRkwEdl73Fjy94VFWxYRVAF4zrLvH7+9yjZOmZuCBfQZn6vB4
	 z7a8wMKEsOk+MEiWLPH/lRnGUjCrexxl78G3QRdHIUU9rCbODup/y4ENRuNYJkc/2P
	 GJ9xnzoz+5CDwPcA7HKmjZY1aHP/hPbsXs4KVjEoL8ktWu7Uz1IvH4B4BgZT3hpxZz
	 RQ6Kh6ju7rVRw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/sysfs: define damon_sysfs_cmd_name type and array
Date: Thu, 26 Nov 2026 13:06:14 -0800
Message-ID: <20261126210619.97634-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126210619.97634-1-sj@kernel.org>
References: <20261126210619.97634-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new struct for kdamond state file user input handling.  The
struct explains what user inputs are for what kdamond commands  Define
an array of the structs for all existing inputs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0049aac6ab974..c76063b703a4a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2254,6 +2254,54 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_tuned_intervals",
 };
 
+struct damon_sysfs_cmd_name {
+	enum damon_sysfs_cmd cmd;
+	char *name;
+};
+
+static const struct damon_sysfs_cmd_name damon_sysfs_cmd_names[] = {
+	{
+		.cmd = DAMON_SYSFS_CMD_ON,
+		.name = "on",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_OFF,
+		.name = "off",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_COMMIT,
+		.name = "commit",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS,
+		.name = "commit_schemes_quota_goals",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
+		.name = "update_schemes_stats",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES,
+		.name = "update_schemes_tried_bytes",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS,
+		.name = "update_schemes_tried_regions",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS,
+		.name = "clear_schemes_tried_regions",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
+		.name = "update_schemes_effective_quotas",
+	},
+	{
+		.cmd = DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
+		.name = "update_tuned_intervals",
+	},
+};
+
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-- 
2.47.3
