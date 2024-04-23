Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211D29AB
	for <damon@lists.linux.dev>; Tue, 23 Apr 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833495; cv=none; b=AGxk8b4u1xG2lYUEuMGNtf2HOEpPYR39qQ8xgAK79dy/QpgogUNa5WYwmrS3FkPuWypTSUWHJ8SWUgLbhi/yGSCZIkJw1XC3SC3GT+GXrR93YJNsbW+WgV/0IvSyRRuXZFl3FwpASFjkOtHKX7UUhg+KlzEsfxo8mMrlnmRAsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833495; c=relaxed/simple;
	bh=CHdZFMuoe6tNgw3BbiZnQmeY4DiLW7I864pHmn1mcCw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aQZ2j19pO94HMsNDi9yJYYulBgW2NJMtuEJRlSEg7KT/qhunsh1ux2dpNK7PV1KvSQWnNjgb5Zi1tv+qElWL2BAaYp+fo2fTLfkOT4p2MPODfINSjXyBJft7mrt1oXp9XB6201kpVdbllcZf+s6gMBaLLeOZlYb15gEWFj4m7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkHDgF8M; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkHDgF8M"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f04581a66so348650985a.2
        for <damon@lists.linux.dev>; Mon, 22 Apr 2024 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713833492; x=1714438292; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CHdZFMuoe6tNgw3BbiZnQmeY4DiLW7I864pHmn1mcCw=;
        b=TkHDgF8MDSB2SHUtNX0QKI8mZYkK1yhjbHhTxeZtDwbjgx+X3f5YLJJhQi57b3r3FI
         rO4efQgcVkh3MFcCYVRvR5U5c8/C0bOeaw1o0GxMR6icCLPcQf+7CNJumwrrInPvDTZl
         vi9wEgcc1TqYU/RDk407LV137l7k5JMBpDuz6RCtYMVNSIA1K1ZGYpNZRrWfxMOs+CV7
         1HQ47XuFfOkKVtXHDRkGCGWCxa07Qlh6LbSWEY5p+VuHB80ecOXz3IrqSBu6OTBzVRQu
         Pu9C7HaYJVVSc7/E9E48v+jYo1r1YFRenJDeBjJnzIgEvL4SSiUn46tCfm+pcVI8i6dT
         Ah8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713833492; x=1714438292;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHdZFMuoe6tNgw3BbiZnQmeY4DiLW7I864pHmn1mcCw=;
        b=AnP9UwErmk/fCPQKZjnBgZGMWlp6ba9cJFO3XPHIW4mnK8FK+wPYk4NFwBKDbLPRmg
         AOl7snEDZnDgd3q69qEt+eStAyIvqcXu3Hkjuwm3mrQVOZd4PhRGiIZptZ9gLtsBM7yU
         hJr4gPo67XsncftsblaJ+8P//An8OEAoBiNY90/mollsr3hFLzJNRPPCT9wuI7tDm1Wb
         4NUdjgMyy5dlSTu9MEAxePPS9cSQttPblMEyxestNkYNvNwwqKnFXVEFeOiOa3aqLis+
         2A0PMT5x/kNqjbwh0fgo7eiX1lKiguzfUt3wIbd4aXDjsReRxTxkQS7SctAz7Zvlh/21
         M4Pw==
X-Gm-Message-State: AOJu0YzgeHFNcmiCQDeCD9JLZruGJ70HJw/oUCVmxwzGNaCx2GI5z5bJ
	US9Q/jyPFUmqjVB4Zq6ZAdJlNwH+PuUzBXmOecWcBwAttUevK4PB9l/qwmbMKucdOfZ6k/3T8/p
	MIwOyOFPERPSpsiT9cmhFRZfNAHb2zOW/ahU=
X-Google-Smtp-Source: AGHT+IFDZY2vyw31VCZlt7lKr9oxy8NoKFyDc1qnQ/X8jGJkCVXk0jS06PrEzgKbFWnq0/4zTqtMqxMCywdk9SOulzU=
X-Received: by 2002:a05:6214:4991:b0:6a0:7c81:cc1a with SMTP id
 pf17-20020a056214499100b006a07c81cc1amr8991848qvb.39.1713833492482; Mon, 22
 Apr 2024 17:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date: Mon, 22 Apr 2024 17:51:21 -0700
Message-ID: <CAKJOkCr86bMoOgxnJQu8Ry-W-2XHYn_xgyZWL4pTPCgcGK3_rg@mail.gmail.com>
Subject: Regarding DAMON sysfs usage to get memory access stats
To: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

I am currently experimenting with DAMON to gather memory access
statistics for virtual address ranges associated with specific
processes. I have followed the detailed instructions provided in the
usage documentation, but it's unclear where to find the resulting
memory access statistics.
 Any pointers on where to get these statistics?

Steps
# cd /sys/kernel/mm/damon/admin/
# echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
# echo vaddr > kdamonds/0/contexts/0/operations
# echo 1 > kdamonds/0/contexts/0/targets/nr_targets
# echo $(pidof masim) > kdamonds/0/contexts/0/targets/0/pid_target
# echo on > kdamonds/0/state

Thanks & Regards,
Lokesh
