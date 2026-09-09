Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C2511235;
	Wed,  9 Sep 2026 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997461; cv=none; b=JAlyvk9Zt51lI8TkitKsrkRN2qR+6Cv26ebn/CsZpouMTMt3yUoKuDv5e0d/n3fNi4Jx+fB/Yy4h7nz3Nhik5whrQVaJ8RoJglBwG/5VrAZw4jHbqHeVRC4dpW9oNgb60qIZA34Ppx90hY780FZdtQlPyVayjgpVAUh40kyOncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997461; c=relaxed/simple;
	bh=oDVCIB/mC53jIcznjnQ0ylerfr82/QQjpHVymnBTZ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOE4qSx5AiOCwvyJ60dz/jLwt3m/+nSBqV7DNc+J9IZnadRtvnRuXj1ASvlOYNn7Z3GWQx/j2eMkl+02CVH30baAK0titr6ThFQIfeZ8i//B32PSqDHsAQuyFv1uosEAkpC2GYG8QcsBXrRMfmVK1YHAM23wDVl2aswlWODgukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvdssDLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvdssDLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21AC1F000FF;
	Wed,  9 Sep 2026 23:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788997459;
	bh=dn6dhmzXIta29auJrOPZZyLCN/0sZUS3eFdMoIZgqmM=;
	h=From:To:Cc:Subject:Date;
	b=kvdssDLKRouNRQdcpwf27BN0zjX3j9PxXzJfF4M7eRuJQtRDP4PsJpuOAGw2kKD/x
	 7Etn+nzVl/9LkREieq7r8A175RXvO0qf9vt496kAIIrMvcfPjbZdTmvhvoBTNID2C6
	 g3XJiGFe2rwM2hpsc7c40uai2/aCmWD6JNSg28qvAmuFWWGe0VxMsHzXp9AkFKOh7L
	 Vq4ZzUIwL8fVWn4aLWsImZJxr+lj52s2lFsr9gmQHle+0/4F4Pv+koxzg4TH+AugiL
	 BcjrM/epQdBAI7qCBDPEWuCuRygDyiLxVPwARZ0s6ykhb1TDRt+ZrlcQRzPGwFbW86
	 6tzrFb4Lk8mNg==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-08-17
Date: Wed,  9 Sep 2026 16:44:11 -0700
Message-ID: <20260909234412.108985-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2026-09-14.

As usual, we have two time slots for meetings in the week.  The slot for
Tuesday is already reserved, though.  I will also be in Europe in the week of
2026-09-28.  Changing the time to CEST.  Next six time slots are as below.

2026-09-14 (Mon) 18:00 PT (not yet reserved)
2026-09-15 (Tue) 09:30 PT (reserved)
2026-09-28 (Mon) 18:00 CEST (not yet reserved)
2026-09-29 (Tue) 09:30 CEST (not yet reserved)
2026-10-12 (Mon) 18:00 PT (not yet reserved)
2026-10-13 (Tue) 09:30 PT (not yet reserved)

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
