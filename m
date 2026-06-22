Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F423B7B7B
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136226; cv=none; b=ViWiw3VAPTKj86eHWvz2Kge22zIm5uqw+yuPFmiyl1pZ56PJvr7hXHhYa8eBm1YpucP1tBjI6PSe914IQTeT3ttJH1Np75dzbQauzDJycU2o59WEIMKim0TwXk56wz/MJLZ0t37lR2aktiEzbvjipQqKHmXXmsvNpBFDcU65aKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136226; c=relaxed/simple;
	bh=3dhYgo+pNP9zjDryLIiYmj/Whq0nFhpgX3flylvnnsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+2B/nQP1B0TxSzhIDVGJsTimgUJ0U/ojn1bSCT/E6OWRrRbgSJHmrNKUooTMa2MuuiPjSCUstahmcUbD9c6uP4nZGmjvLJSnX8b012AJiaj+C2bi5eePX5xAUxG0jymOPHTejDsImhERxwgTbPai0Mb5RjynGqQwNVe6ee4pcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7hodTHZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7hodTHZ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8422f148dfcso2454788b3a.3
        for <damon@lists.linux.dev>; Mon, 22 Jun 2026 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136223; x=1782741023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKgW4+pNodbEv/Swhh7lEYX3onGIwRL3Ox7oRUBNEns=;
        b=V7hodTHZfckEOwBVEzG6cV2qojGi1TPMrD5apozt6rWw8zwOvbR24rHuxuPKIq1JjO
         yvdIoka7svBsl9Cg0GsabCflT3qgFXLt2380mbwfD1/aKUXQkKgNTaPFS9WXOkTWRskX
         JgmETZxtlAfN0RTfWd3KM4IBW47vx+z69U1rJLJtnO4LM9AAGtUeGAcnoMDw9ivt4BMO
         cdcdZ+1nknMv5IbfgASIHDln12BYTZbSfBG5fzeL2Yqp7LH8A0JjE9obZ+gmMi8m94yt
         8uYp/n1KZu29H7VzL7PAFHfuovgIavKdZkcIoShwV8sOHAAAj2YOccyO1ebVy3ZgvE6Q
         hFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136223; x=1782741023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKgW4+pNodbEv/Swhh7lEYX3onGIwRL3Ox7oRUBNEns=;
        b=RJrpukPnwFaIzx1uIDAcBWbJY4bJJORRC7OXfuBALc+LW3LwT+WmDcdn9AH3M0mHiP
         Bb2r5M64boInOY+7YxLLkrbyrQ1FEYLDEvLRp+j1TSmLw29hEiABuhMfUhkaphkVMPIa
         dKg2uVaS+zf95QkMN/WN8+swD14TL9su0A7Lm1mdlULz515xISZkcZbWhppYZvUSUZkz
         MZ9QqIypMWYJlXSyBpe3dm9ASdEbHhKhT6ln6Vjn5HeviyCQXDBucnZeNZ9fbKKXn1CW
         Jt1//6wH+eLYZsAqod9Dk4mOf7CxLhKpnyG7pLvAoHhQ6aMKjnaTMpCcnFTc5rkK/o3f
         jeWw==
X-Gm-Message-State: AOJu0YxelfwroIr1NXuN6o6BmgJIPJv3/LmW0c6JLHXofamSeZmpN1iy
	Otk/Wo5kGjn6mUWWgTJ9g0J5f5hnpfGGgDzQUJbKlUVy5WpYRk5ULZXyuCaBzA==
X-Gm-Gg: AfdE7cm9fzoSn/pMMoQ8cUGHjcXdIhu9Jq6IJWM0j51vwqRNIbrQclI00aUP6d+AoVc
	iXBVx+BxeqeSG0Zuw++Ro0EhOzbogVLeCjx7M/+TTIfG8rXuYHjeeyKB/AACNRQqDzfVTfrxw2p
	usoO1iqJAJ5nffNwsvTj6re/5MMtFmCJZsFu54t1RxjdZ4YNjcxQZW7a2CBI09ySYoXzGu5TT05
	eY8/NjMFKCcwhVMBiJqEr/G9umN9rqN6e/Fql+9jOP4pwCj1BU0PnOe1W1EGlvTTBP3AhCOfJ48
	H90tH60GEzV6lcpUuQzk8KDFOyfj/XR76J7yBrEVDvXqAtwFUMJ2WryZqikJNHDL9Ke2v50tAWf
	saJcboNNlYhWwCIyQyVb6M1b4cZg1TfonMqK053V+vm5NIU/a+UHdGcNlj83dwzrb2oKhg8ogdA
	lssqUpeesK8heObPGOCNLlNXjghQ==
X-Received: by 2002:a05:6a00:14d3:b0:845:4d3d:c8c with SMTP id d2e1a72fcca58-845508c0737mr15848543b3a.39.1782136223267;
        Mon, 22 Jun 2026 06:50:23 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:47f:2522:acac:f810])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea146asm7606177b3a.43.2026.06.22.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:50:22 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	ravis.opensrc@gmail.com,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 1/2] perf python: Add access to various members of evsel
Date: Mon, 22 Jun 2026 22:49:32 +0900
Message-ID: <20260622134933.35773-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622134933.35773-1-akinobu.mita@gmail.com>
References: <20260622134933.35773-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change is necessary to specify the same PMU event selection as the
'perf record' -e option from DAMON's userspace tools.

For example, a Python script like the following will allow you to obtain
the values to be set in the type, config, config1, and config2 members of
perf_event_attr by providing a symbolic event name.

import perf

if __name__ == '__main__':
    evlist = perf.parse_events("cpu/mem-loads,ldlat=30/P")
    for evsel in evlist:
        print(f"{evsel}: type={evsel.type} config={evsel.config}",
              f"config1={evsel.config1} config2={evsel.config2}")

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..3f108b405ee3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1241,11 +1241,60 @@ static PyMemberDef pyrf_evsel__members[] = {
 	evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample_type."),
 	evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_format."),
 	evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_events."),
+	evsel_attr_member_def(config1, T_ULONGLONG, "attribute config1."),
+	evsel_attr_member_def(config2, T_ULONGLONG, "attribute config2."),
 	{ .name = NULL, },
 };
 
 static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
 
+static PyObject *pyrf_evsel__get_freq(struct pyrf_evsel *pevsel, void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.freq);
+}
+
+static PyObject *pyrf_evsel__get_exclude_kernel(struct pyrf_evsel *pevsel,
+						void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.exclude_kernel);
+}
+
+static PyObject *pyrf_evsel__get_exclude_hv(struct pyrf_evsel *pevsel,
+					    void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.exclude_hv);
+}
+
+static PyObject *pyrf_evsel__get_precise_ip(struct pyrf_evsel *pevsel,
+					    void *closure)
+{
+	return PyLong_FromLong(pevsel->evsel.core.attr.precise_ip);
+}
+
+static PyGetSetDef pyrf_evsel__getset[] = {
+	{
+		.name	= "freq",
+		.get	= (getter)pyrf_evsel__get_freq,
+		.doc	= PyDoc_STR("freq"),
+	},
+	{
+		.name	= "exclude_kernel",
+		.get	= (getter)pyrf_evsel__get_exclude_kernel,
+		.doc	= PyDoc_STR("exclude_kernel"),
+	},
+	{
+		.name	= "exclude_hv",
+		.get	= (getter)pyrf_evsel__get_exclude_hv,
+		.doc	= PyDoc_STR("exclude_hv"),
+	},
+	{
+		.name	= "precise_ip",
+		.get	= (getter)pyrf_evsel__get_precise_ip,
+		.doc	= PyDoc_STR("precise_ip"),
+	},
+	{ .name = NULL, },
+};
+
 static PyTypeObject pyrf_evsel__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.evsel",
@@ -1255,6 +1304,7 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_doc		= pyrf_evsel__doc,
 	.tp_members	= pyrf_evsel__members,
 	.tp_methods	= pyrf_evsel__methods,
+	.tp_getset	= pyrf_evsel__getset,
 	.tp_init	= (initproc)pyrf_evsel__init,
 	.tp_str         = pyrf_evsel__str,
 	.tp_repr        = pyrf_evsel__str,
-- 
2.43.0

