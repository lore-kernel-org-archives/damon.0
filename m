Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B5349CC2;
	Wed,  1 Jul 2026 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939255; cv=none; b=iYx+jfD9vAS3IlzLgEQ+/ChkyKaVtBYoMU0Jbcdle0MpSzI9J52RWNWS0CSsRY43UmcTmx2biZbYIfZ773VD+O/+8eALdyvDlQfZQBH5zp4uSaf8Jywp98o4mlH3qcTwBGd/P4gXvtS/HI+3/O7+cYPwt1cXme2FEJTKEujRMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939255; c=relaxed/simple;
	bh=JGkhGnZXLxEK1ITp0pgmRsx5CbQ8bHiXqC/uWmEVJPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKEjO2EAhAKeVql9kTQKEk9smOp/1+dWTLSBfxBF8arsc8PNzKAqam/A/mDfn05+bOuaps9B+gBNcq2oBa4aQXkeZa6/l1kiVk+4mfGZ6Hi77Y6qVDkkyvS/mu33JwOuwoc1R+VxeFBmeVFeEkQKZNOWyx8xHOzRnnPYwnfntvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJAh1QyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJAh1QyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6CF1F000E9;
	Wed,  1 Jul 2026 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782939253;
	bh=MF/4v99QlpO64wl/icDp6fFQHdTLtVutc46q7dtd+2M=;
	h=From:To:Cc:Subject:Date;
	b=gJAh1QyYnJfg29dXr/4zmtsMQvwOOT4l1R8RJF2eFUAqsJMH/deddGy2Q0qHGdoO3
	 mNwxHcS7g45kFfrhZ5k5S3tDQFAETZGjfP7vQ3UQrrL1i3jJtcjmwp2xdl0Fy2051Z
	 n4RvnU7GVkn91RpL3fwPx0zlF2PNdDbAtjDKmX6uXoyVEzXT916YEZ+oxhdoFXYaQX
	 aSMupRlDLaSpqrgGx4NEOjYm+ToRsHbYxk4trkCGiSLAqPTYC+vPL469u93XEBscD0
	 PHQmx7/6uT3I+ysKFbeZjS+GxAQL6FzMLdpvjcwBxgtU/johK+TteytY/Ax+0obbPK
	 CTog90H35WHlg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-07-06
Date: Wed,  1 Jul 2026 13:54:09 -0700
Message-ID: <20260701205409.22475-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2026-07-06.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-07-06 (Mon) 18:00 PT (not yet reserved)
2026-07-07 (Tue) 09:30 PT (not yet reserved)
2026-07-20 (Mon) 18:00 PT (not yet reserved)
2026-07-21 (Tue) 09:30 PT (not yet reserved)
2026-08-03 (Mon) 18:00 PT (not yet reserved)
2026-08-04 (Tue) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available on demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t


Thanks,
SJ
