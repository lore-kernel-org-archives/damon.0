Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD28187850
	for <damon@lists.linux.dev>; Thu, 26 Sep 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385544; cv=fail; b=tg7dEH84e87jM2dJqiCDl9pc+SIhA65vBUdP26LpHYJ+rJFq8Bav5IhXqSBguuqwi/I7ATkng68ZzegB5Od+xpAGsKdGGDDJWeBUBIAVgHqVmQhB9zoLSpdWT1xmW6/zyNskz6R6OcFAaYoHk7TB9JFY5D25QCBLgMnm51FgVM4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385544; c=relaxed/simple;
	bh=KDvT49BCROK57yxcN2eg9fABo/Fg0C31CChC+F5MKMk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LsuH+gv21sMy8AZX4hUVctifC7bE3uNs+5mFfDL2cH5VVAiWWWbdetxY50ULsgEE8V05PAmJ/Y0LpcpDA4mwWeXwwCKcWkbh/ZoBVPi2pBIRThIm6hzA1BhofpycvIIcF6ShZhjAzGY9SOa0jwJcalve56DAWdZaP5Lqd0keMcc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZR+Be3uQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZR+Be3uQ; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZR+Be3uQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZR+Be3uQ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wsAJ7r9WoBxHmUhyZVQD8bnstYDIT6/KNTlPE0C4NI24B3Nh8a6BZgEC5/gXc1nyN/oIxhrFLRRoC0LiWb1CFbC5279u7VVOQlHR3nVVqTsr+3ihmJRS3lFpVnUDRBWjCLwoGY4MoImitXOMuhw9unRCPCDr7zmqYxdjaR+/Ahf0PKz8IaUkjPP/Hdcp08miWE7i2VhhPV8G/iQyf+RxGg+LCLd7ndfmBUanPL6COFJInn9deDYWShs5UNjLlQXUXQMv7vVxztQIzWlkDDW2iePfk3c93NKcE7/aPrB0SQ1MUhJjCvgLywSMGi3o/vuFY+P2Mhn+llKiG+aN1mHFwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDvT49BCROK57yxcN2eg9fABo/Fg0C31CChC+F5MKMk=;
 b=DS2hcZuI3DGWOudTGFgcoPIix1vjszx2HyG5QT9q6gysMjmYX/k8zP+ajhlu0lBPl4hRceMN+6okozCTgNS0k3Y2m9CZ4lbK/uilnP/d5NS9TccOoCCoItCN5yNGDZ67MntBXh8OMz0VKX/1qfrcJAEFOhQdGw1cXD9HBMAnrgN+gBN+pOmu5hauUc+Yg1HM77kTLpgWxKwP5MaHT7uD7KMRxKrHtIBW2zTb/iLkIvP6/isAJD0hJe6WS0QPtbXW6Z+nnOOPfEwecXqUh+Ql7o0mSH8NYPxIDWnhen3Vsgm3Qur+JQkuWymadJ4UxE0WVRBR6yYAfzEbFtB7+snEwQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDvT49BCROK57yxcN2eg9fABo/Fg0C31CChC+F5MKMk=;
 b=ZR+Be3uQNj0bDrg9cZ77faun5G9eQyrwkWpQqOBH/Dg/ENt6u2Kl9dY01xT9GmunfMQpFWK7MD27GlqFqj/BAnH9zcqfDy2J7vmmOWN0dHUlFBd4vVCErtfoUXRffnlgxo/UIg9BUw/iWdCuoSP9ONbrjOZWkFzNDl+YF5jBOOc=
Received: from AS9PR06CA0681.eurprd06.prod.outlook.com (2603:10a6:20b:49c::26)
 by AS8PR08MB9599.eurprd08.prod.outlook.com (2603:10a6:20b:619::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Thu, 26 Sep
 2024 21:18:53 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:49c:cafe::26) by AS9PR06CA0681.outlook.office365.com
 (2603:10a6:20b:49c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Thu, 26 Sep 2024 21:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Thu, 26 Sep 2024 21:18:51 +0000
Received: ("Tessian outbound 2e8248bf46c3:v465"); Thu, 26 Sep 2024 21:18:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f9077791754fa574
X-TessianGatewayMetadata: qUrnX4xDmGIzluJX8fJTWV9EZp8gCcJJ7QKLcmuR0kg8jkD5+n1UtCOXFXQtdqpd4sEhQyC3XAslnva8aYVNDILLwnvKlwhe6Cf/oQcKMQaeTM+Y5kIQkksV+afnFk/FlKT4b/Gf3lNLTYMAQMp54Oc9NXIhOMCGv1yQdN0oX6KaLOojXjWSinLSwFWQNcGga+SidHDDKKKghwF+W3KU2w==
X-CR-MTA-TID: 64aa7808
Received: from Ldb58316e7b22.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9D85108C-50E2-482F-8C7D-63C8E44F5EAF.1;
	Thu, 26 Sep 2024 21:18:44 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldb58316e7b22.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Sep 2024 21:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT0w8UZMa2rglLZBACFCeN/TH7lhn+aK7lxJhVcj0yrRfphMr8Iv1wIxFq7J06WayxApVR6eLOjqK/ainJTdDBTtTaguwhMqF9+ShzsMPO8Fdpo83k9keIxxJQLVzzHo7p2+uZPRjYUgOl5sZdzYB33zD45KB2+9BYzKQEGpxPpVf135D4W1WOGduMJfyDsV2wFjfGFWyf0IN8RylGPrgnHT2lJstxOC5Hu8kkSl3Yfg80y+TNgZpbq5LjdRGpSgI6AHqvJRSsDNKYHFhHbxFl9f25mOdOlDF4EB4LbXLI03FsPFW/G4BMX1d6U49SUZDN9VHPtunv7LeI5sZbALtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDvT49BCROK57yxcN2eg9fABo/Fg0C31CChC+F5MKMk=;
 b=xXjib5XDxJAq3ef4G5h3037jxEy85AYURNWx3/Kxm2kB8x2D2Nu9M04+utNZgFHghxP9USM439Ev7/RJw4MevRQLoIFkWohJwQSxzwy8IsC5u23UPtHmQd+l5jvrRnr0d5Ln7JvJ8zPL3MkGhWMxJ3R3QtdDWgOm9FCnHJa+UWWbgmDRJkW9WsMmkiWBu7ueScWT4Gkeb4JXg7/GyQ9u4R8WFD1w9NmRJN173pbdz9b8T9SqvkIuhsciV1bRtdKue9JfHkpj7vw+S6LX0fXwPiMZpMZIcab8dO2shwSFa5q+Byx6cT7mRqaH7UanHZC1TWvUrWW0Ds7eNnrztOm1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDvT49BCROK57yxcN2eg9fABo/Fg0C31CChC+F5MKMk=;
 b=ZR+Be3uQNj0bDrg9cZ77faun5G9eQyrwkWpQqOBH/Dg/ENt6u2Kl9dY01xT9GmunfMQpFWK7MD27GlqFqj/BAnH9zcqfDy2J7vmmOWN0dHUlFBd4vVCErtfoUXRffnlgxo/UIg9BUw/iWdCuoSP9ONbrjOZWkFzNDl+YF5jBOOc=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6529.eurprd08.prod.outlook.com
 (2603:10a6:20b:354::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8; Thu, 26 Sep
 2024 21:18:37 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.8005.010; Thu, 26 Sep 2024
 21:18:37 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: subscribe
Thread-Topic: subscribe
Thread-Index: AQHbEFmjbTTPii4PCEmWzRgJ44Jxdw==
Date: Thu, 26 Sep 2024 21:18:37 +0000
Message-ID:
 <GV1PR08MB10521C8CA9CE7D0D1C2AEB211FB6A2@GV1PR08MB10521.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6529:EE_|AM2PEPF0001C70F:EE_|AS8PR08MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: b2642343-7cdf-4a33-0cde-08dcde70d1a8
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?UZPo36As+SBT265TQtDLqeOXvdb1neljcL0uLukjq75LcNM7Mg/IknClOr?=
 =?iso-8859-1?Q?Vm+bU+rDNI3p0EJj113Mqju0couZM+e4XMQmrPhQ9ElTc7MwfPOtpIoE2d?=
 =?iso-8859-1?Q?B9SMZ43oPWGsOefpc7HHCq55neQcZn5RX+Okz6QlOaRFh6egVV0sgN8h2O?=
 =?iso-8859-1?Q?UPpeNkDcxc43QwwvLUV2ufWaBex8DYpushwMz2gFx127e+pkYbjs5RxsRs?=
 =?iso-8859-1?Q?a5hlKxrKwQnJYcdeEes0YZn6ofr1A4O1jx2nwvERQKI2vm1AGH9w9LiD9U?=
 =?iso-8859-1?Q?+lHYqUN9GVDZAizjEIJZl0FOVc+XNyF/O6f1BUtcvPv195ak+P4LtQaQ8B?=
 =?iso-8859-1?Q?Ma1dknEkKxyYs6TOvsJ9yZP1InRVv0OClOKkb3SRI82kdgBmR3qTqhZsHL?=
 =?iso-8859-1?Q?M4d2A50aNfsW6zL50cQCZm7z1vC/uybvnJvdhunwANYuNqBkWpyMuKU+P/?=
 =?iso-8859-1?Q?AfNSlsSxbBRnJF/cCq+CB2t0IAIAUyiEXxQTeBIZPSml3X/oNJyFcGXEn3?=
 =?iso-8859-1?Q?pHKKYKqfpJI4ZFNuvZYPxr67muqLSqKK+/lkCrRChwK5HVOLo/UecHTEVX?=
 =?iso-8859-1?Q?GzXgrHf/4fnIFtwZMkAb1ofsAk/FgVk+mbhwGeCjo9n7UepAvn5D5K4pL/?=
 =?iso-8859-1?Q?+W9cBOE9hguairsbSHQfnX0RxABnYnvQapfT/e5QXb9LQEWo05Dbw4j5My?=
 =?iso-8859-1?Q?gVtPqkJ+L3wr5rSyqAM7Cqn4ivgyTZBVgjt3BLyT7iZywfZmZ4Vqsv8dFJ?=
 =?iso-8859-1?Q?S0a+FL3ZJBXr/XAgPvOVTkRbluMN02HldFwZAUrMZkM5Tn9ZhN9H0amNnv?=
 =?iso-8859-1?Q?txQAPzL3UhpLiokonAlpMwtUHB/HjGnH71ed0JKMCBxKqF6VoqMFh9SSJd?=
 =?iso-8859-1?Q?du6/smPadomw/IagbKtsiAc4SHEBr0giYre7b0bccPNeKSaaDmEvafxxbj?=
 =?iso-8859-1?Q?atVHZMliHiOTbwwecz4cF+iFgpcIdjsx6haTvqr6aJe47SCN05ucoUbW57?=
 =?iso-8859-1?Q?+32BDO2UmSDzGTrAgy0kPbNf5mlFJk4X3stQjKVVBv1XfOouyTNI+wQkS0?=
 =?iso-8859-1?Q?KYWYil6S0mB8XtXo1TAkP5hrsNdXvneH54t74ttejDfb?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6529
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e960e2b9-95cc-4e3e-819f-08dcde70c95a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?enkI6ut/HqwbvSytXCkz4LpQsz4uCXOhslwEZ4eyidA2wV2aFwR53DUugs?=
 =?iso-8859-1?Q?uEIvXtFYelePRDBmSzXE3XKSWpw/fZq0gtr8uFChJ9VKCIpPtGTmfLaylX?=
 =?iso-8859-1?Q?hkYU2LpvwBSVj5jRVUm1NS+cFIjBFq3txNIuttete3UfNuGZzj2cH1HscH?=
 =?iso-8859-1?Q?HpfE0iyc3meBKC+9bzqwOGg1Os8Jo/urA/sAVC3NY7gOjFW0c5R608c3pO?=
 =?iso-8859-1?Q?RoNNz+X3FJd/VKI9+L3Wl5/LDYi/f8vZt2odrGqsU0dg9/V5Hli/uNVLqN?=
 =?iso-8859-1?Q?wX7HUUgu/VhRCcaqMtzOmzkXOO3bYQyrTo5pZC94g1xs8zVaxedw21uRHG?=
 =?iso-8859-1?Q?RzD/kA8swdbsR9ykHYmmc/F/vmYR2791ls9s1u41/FdL1kmHDE8mGanNMC?=
 =?iso-8859-1?Q?QTtddMw6eibbF6rVxzKomQOfaNDfPRwy6qbdeqpC+wE1m/mAGrJkc8/isI?=
 =?iso-8859-1?Q?Ijrq7E653Eoo3a/ti0USHvPK3NFi72osDPTFBwYNavHh7ESMTuMFmOtgzG?=
 =?iso-8859-1?Q?WtK/rPM6xygai+osd1oBzlQ01o4YxrL67JE1SVPr0AfzoKp87/oaNpD7eJ?=
 =?iso-8859-1?Q?gitA5nTlWDvQVkJPKs24Nh0PhjaIoFAJs/HAovbAbl469hPniIp7HWv566?=
 =?iso-8859-1?Q?JrC5sBvfYcU60qjj9uZFqn8AbCGPa+c840A72mL3ETCUxaWh2I5kDLfjyh?=
 =?iso-8859-1?Q?YBw8sOATopk3ruXKLru3mS2FKaqSrbldu8+qDjscf7usFjZrbixg1JFKst?=
 =?iso-8859-1?Q?+PxDCe8/2DkIZtEbmaiNtUxEL+ZuD6jhqjBdosCCqBjbiUMvTjSeH/Ilrr?=
 =?iso-8859-1?Q?YujygRftaNx3VdOzvVIe6rVZR1eLJbJJQ5mxHRcIWrsoPyn7U2bUROwioO?=
 =?iso-8859-1?Q?z0XHTLW9TngP3TN9+tA+gGHKzNa6Gz0L3thpL64zb5b+s4b0P9pJywPZQo?=
 =?iso-8859-1?Q?ADKnAFnU9EumeqA8e+GcmZrWORgmcoHJmnNBqpZTlvBzVjTid/L58N4NFB?=
 =?iso-8859-1?Q?7BqtN1rJZCLWVUaZIMbQXHgjWI/Lp4WZ0c9Qn9q4v+qeUxVgoP4JVb39Hu?=
 =?iso-8859-1?Q?xYwIjCdIcfIXYof/WDNIGy+F9gc4d2GLckm5FGkQxpLf9vik4lhAixYGel?=
 =?iso-8859-1?Q?crnBJK72tBNl5pCx4dqd0vf6BkUxOAlO+WPMYbfw3s0x95c66f7zk3S5xv?=
 =?iso-8859-1?Q?4u0+4RYExedmLcBaaSpWs7RquC4a+tuyEiVnFL7mH6sRNWsSJ7ua3odZq8?=
 =?iso-8859-1?Q?RxDvqATQ6SCrLRku9ZkDvlPNjXmQ/wTWvyYfqI8PeDwQdkCqf8PQl+aO4X?=
 =?iso-8859-1?Q?N32RidCbz7/3tyXf5Jjzg0Aq2pz8T6C/8RwtXZwh5cfO0sMmjXVX4hf2de?=
 =?iso-8859-1?Q?W/0QbQXHEune2xIyVFq2V4gA5L4tm0cMFFhLFk+tXDVILGzdmEc24=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 21:18:51.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2642343-7cdf-4a33-0cde-08dcde70d1a8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9599

subscribe
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
